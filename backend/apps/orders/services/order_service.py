from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction
from typing import Optional
from apps.orders.models import Order, OrderPosition
from apps.users.models import UserModel, UserProfileModel
from apps.products.models import Product, Accessory
from apps.supplies.models import Supply
from apps.basket.models import Basket, BasketItem

from apps.db_utils import get_object_or_error


@transaction.atomic
def create_order(data: dict) -> Order:
    '''
    Create an order with billing details and order positions.
    
    Expected data structure:
    {
        "order_notes": str,  # Optional. Additional notes for the order
        
        "customer_data": {
            "email": str,                       # Required if customer id provided, and required if customer_email not provided
            "subscribtion_updates_news": bool   # Optional, defaults to False
        }
        # Required if customer_email not provided or customer has no profile
        "billing_details": {
            "first_name": str,      # Required
            "last_name": str,       # Required
            "company_name": str,    # Optional
            "country": str,         # Required
            "state": str,           # Optional
            "region": str,          # Optional
            "street_name": str,     # Optional
            "apartment_number": str, # Optional
            "zip_code": str,        # Optional
            "phone_number": str     # Required
        },
        # basket 
        "basket" {
            "id": int               # Required if basket provided
        }
    }
    
    Returns:
        Order object with:
        - Generated unique order ID
        - Initial status "processing"
        - Linked customer (if provided)
        - Billing details snapshot
        - Created order positions
    
    Raises:
        ValidationError: 
        - If anonymous order without billing details
        - If authenticated user without profile (for billing details)
        - If database integrity error occurs
    '''
    # Initialize variables
    order_notes = data.get("order_notes", "")
    customer_email = data.get("customer_data", {}).get("email")
    customer = UserModel.objects.filter(email=customer_email).first() if customer_email else None
    
    billing_details = data.get("billing_details")
    billing_details_snapshot = None
    
    basket_id = data.get("basket", {}).get("id")
    basket = get_object_or_error(Basket, basket_id) if basket_id else None
    basket_items = BasketItem.objects.select_related('product', 'accessory').filter(basket=basket)
    
    if not basket:
        raise ValidationError("Basket is required to create order.")
    
    if not basket_items.exists():
        raise ValidationError("Basket must contain at least one item to create an order.")
    
    if not customer_email:
        raise ValidationError("Anonymous orders must include customer_email.")
        
    # Handle customer profile if customer_email is provided
    if not customer:
        customer = UserModel.objects.check_and_create_anonymous_user(email=customer_email)
        
    # Validate positions data
    if not basket_items.exists():
        raise ValidationError("Basket must contain at least one item to create an order.")
    

    try:
        # Handle provided billing details
        if billing_details:
            # Validate required billing fields
            required_fields = ['first_name', 'last_name', 'phone_number', 'country']
            missing_fields = [field for field in required_fields if not billing_details.get(field)]
            if missing_fields:
                raise ValidationError(f"Missing required billing fields: {', '.join(missing_fields)}")

            billing_details_snapshot = UserProfileModel.objects.create_snapshot_profile(billing_details)
        elif not billing_details:
            if not hasattr(customer, 'profile') or not customer.profile:
                raise ValidationError("Billing details neither provided nor available from customer profile.")
            billing_details_snapshot = UserProfileModel.objects.create_snapshot_profile(customer.profile)

        # 2. Step - Create Order
        order = Order.objects.create(
            customer=customer,
            billing_details=billing_details_snapshot,
            order_notes=order_notes,
        )
        basket_positions = []
        total_order_price = 0

        # 3. Step - Create Order Positions and update stock2
        for basket_item in basket_items:
            supply = basket_item.supply
            accessory = basket_item.accessory

            if not supply and not accessory:
                raise ValidationError("Each position must have either 'supply' or 'accessory'.")

            quantity = basket_item.quantity

            supply = None
            product = None
            accessory = None
            position_total = 0

            if supply and supply.quantity < quantity:
                raise ValidationError(
                    f"Not enough stock for supply ID {supply}. "
                    f"Available: {supply.quantity}, requested: {quantity}."
                )
            else:
                product = supply.product
                position_total = supply.price * quantity

                # update stock
                supply.quantity -= quantity
                supply.save()

            if accessory and accessory.quantity < quantity:
                raise ValidationError(
                    f"Not enough stock for accessory ID {accessory}. "
                    f"Available: {accessory.quantity}, requested: {quantity}."
                )
            else:
                position_total = accessory.price * quantity

                # update stock
                accessory.quantity -= quantity
                accessory.save()

            total_order_price += position_total 

            basket_positions.append(BasketItem(
                basket=basket,
                accessory=accessory if accessory else None,
                product=product if product else None,
                supply=supply if supply else None,
                quantity=quantity,
            ))

        # Bulk create order positions
        BasketItem.objects.bulk_create(basket_positions)

    except IntegrityError as e:
        raise ValidationError(f"Database error: {str(e)}")
    except Exception as e:
        raise ValidationError(f"Unexpected error: {str(e)}")

    return order


def get_order_by_id(order_id: int) -> Order:
    return get_object_or_error(Order, order_id)


@transaction.atomic
def update_order(order_id: int, data: dict) -> Order:
    order = get_object_or_error(Order, order_id)

    if "order_notes" in data:
        order.order_notes = data["order_notes"]

    if "customer_email" in data:
        customer = get_object_or_error(UserModel, data["customer_email"])
        order.customer = customer
        
    if "status_transcription" in data:
        order.status = data["status_transcription"]

    order.save()
    return order


@transaction.atomic
def delete_order(order_id: int) -> None:
    order = get_object_or_error(Order, order_id)

    try:
        order.delete()
    except Order.DoesNotExist:
        raise ValueError(f"Order with id {order_id} not found.")
    except IntegrityError as e:
        raise ValueError(f"Cannot delete orders {order_id}: {str(e)}")