import logging
import uuid
from uuid import UUID

from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction
from django.utils import timezone

from apps.basket.models import Basket, BasketItem
from apps.db_utils import get_object_or_error
from apps.products.models import Product
from apps.supplies.models import Supply
from apps.accessories.models import Accessory
from typing import Optional

logger = logging.getLogger(__name__)


class BasketItemCreationError(Exception):
    """Custom domain-level error for basket item creation."""
    pass


def migrate_guest_basket_to_user(guest_token, user):
    """
    Migrates all items from a guest basket to an authenticated user's basket.
    
    Args:
        guest_token (str): UUID string of the guest basket
        user (User): Authenticated user object
    
    Returns:
        dict: Migration result with success status and details
    """
    if not guest_token or not user:
        return {"success": False, "reason": "Missing guest_token or user"}
    
    try:
        # Validate guest_token format
        UUID(guest_token)
    except (ValueError, TypeError):
        logger.warning(f"Invalid guest_token format: {guest_token}")
        return {"success": False, "reason": "Invalid guest_token format"}
    
    try:
        # Get active guest basket
        guest_basket = Basket.objects.get(
            guest_token=guest_token, 
            is_active=True
        )
    except Basket.DoesNotExist:
        logger.info(f"No active guest basket found for token: {guest_token}")
        return {"success": False, "reason": "Guest basket not found"}
    
    # Get guest basket items
    guest_items = BasketItem.objects.filter(basket=guest_basket)
    if not guest_items.exists():
        # Empty guest basket, just deactivate it
        guest_basket.is_active = False
        guest_basket.updated_at = timezone.now()
        guest_basket.save()
        return {"success": True, "items_migrated": 0, "reason": "Empty basket"}
    
    try:
        with transaction.atomic():
            # Get or create user basket
            user_basket, created = Basket.objects.get_or_create(
                user=user, 
                is_active=True,
                defaults={'created_at': timezone.now()},
                discount_code=guest_basket.discount_code
            )
            
            migrated_count = 0
            merged_count = 0
            
            for guest_item in guest_items:
                # Check if same product exists in user basket
                existing_item = BasketItem.objects.filter(
                    basket=user_basket, 
                    product=guest_item.product
                ).first()
                
                if existing_item:
                    # Merge quantities
                    existing_item.quantity += guest_item.quantity
                    existing_item.updated_at = timezone.now()
                    existing_item.save()
                    merged_count += 1
                    
                    # Delete guest item
                    guest_item.delete()
                else:
                    # Transfer item to user basket
                    guest_item.basket = user_basket
                    guest_item.updated_at = timezone.now()
                    guest_item.save()
                    migrated_count += 1
            
            # Mark guest basket as migrated
            guest_basket.is_active = False
            guest_basket.updated_at = timezone.now()
            guest_basket.save()
            
            logger.info(
                f"Successfully migrated guest basket {guest_token} to user {user.id}. "
                f"Items: {migrated_count} transferred, {merged_count} merged"
            )
            
            return {
                "success": True,
                "items_migrated": migrated_count,
                "items_merged": merged_count,
                "user_basket_id": user_basket.id,
                "discount_code": user_basket.discount_code.code if user_basket.discount_code else None
            }
            
    except Exception as e:
        logger.error(f"Error migrating guest basket {guest_token} to user {user.id}: {str(e)}")
        return {"success": False, "reason": f"Migration failed: {str(e)}"}


@transaction.atomic
def add_item_to_basket(
        basket: Optional[Basket] = None,
        accessory: Optional[Accessory] = None,
        product: Optional[Product] = None,
        supply: Optional[Supply] = None,
        quantity: int = 1
        ) -> BasketItem:
    try:    
        basket_item = BasketItem.objects.create(
            basket=basket,
            accessory=accessory,
            product=product,
            supply=supply,
            quantity=quantity
        )
    
        return basket_item
    except IntegrityError:
        # Database-level integrity failure
        raise BasketItemCreationError("Failed to create BasketItem due to database constraints.")

    except Exception as e:
        # Catch only truly unexpected errors
        raise BasketItemCreationError(f"Unexpected error during BasketItem creation: {str(e)}")

@transaction.atomic
def remove_product_from_basket(item_id: int) -> None:
    item = get_object_or_error(BasketItem, object_id=item_id)
    item.delete()


def get_basket_total(basket_id: int) -> float:
    basket = get_object_or_error(Basket, object_id=basket_id)
    total_sum = 0

    for item in basket.items.all():
        if item.supply is not None:
            price = float(item.supply.price)
        elif item.accessory is not None:
            price = float(item.accessory.price)
        else:
            # Optional: skip items with neither (or raise error)
            raise ValueError(f"BasketItem {item.id} has no supply or accessory.")

        total_sum += price * item.quantity

    return total_sum


@transaction.atomic
def get_or_create_basket(request, response=None):
    """Handle both authenticated and guest users consistently"""
    
    if request.user.is_authenticated:
        basket, _ = Basket.objects.get_or_create(
            user=request.user, 
            is_active=True
        )
        
        # Optional: Handle guest-to-user migration
        # guest_token = request.COOKIES.get("guest_token")
        # if guest_token:
        #     migrate_guest_basket_to_user(guest_token, request.user)
        
        return basket
    else:
        pass
    # Guest logic
    # guest_token = request.COOKIES.get("guest_token")
    
    # if guest_token:
    #     try:
    #         uuid.UUID(guest_token)  # Validate format
    #         basket, _ = Basket.objects.get_or_create(
    #             guest_token=guest_token, 
    #             is_active=True
    #         )
    #     except (ValueError, ValidationError):
    #         # Invalid token, create new
    #         guest_token = str(uuid.uuid4())
    #         basket = Basket.objects.create(guest_token=guest_token)
    #         if response:
    #             response.set_cookie("guest_token", guest_token, 
    #                               httponly=True, max_age=60*60*24*30)
    # else:
    #     # No token, create new guest basket
    #     guest_token = str(uuid.uuid4())
    #     basket = Basket.objects.create(guest_token=guest_token)
    #     if response:
    #         response.set_cookie("guest_token", guest_token,
    #                           httponly=True, max_age=60*60*24*30)
    
    # return basket


@transaction.atomic
def attach_guest_basket_to_user(user, guest_token):
    try:
        guest_basket = Basket.objects.get(guest_token=guest_token, is_active=True)
        # merge items into user's active basket
        user_basket, _ = Basket.objects.get_or_create(user=user, is_active=True)
        for item in guest_basket.items.all():
            existing, created = user_basket.items.get_or_create(product=item.product)
            if not created:
                existing.quantity += item.quantity
                existing.save()
            else:
                existing.quantity = item.quantity
                existing.save()
        guest_basket.is_active = False
        guest_basket.save()
    except Basket.DoesNotExist:
        pass
    
    
@transaction.atomic
def clear_basket(basket_id: int) -> None:
    basket = get_object_or_error(Basket, object_id=basket_id)
    basket.items.all().delete()
    basket.is_active = False
    basket.save()
    
