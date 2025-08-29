from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.orders.models import Order, OrderPosition
from apps.users.models import UserModel, UserProfileModel
from apps.products.models import Product, Accessory
from apps.supplies.models import Supply

from apps.db_utils import get_object_or_error


@transaction.atomic
def create_order(user, data: dict) -> Order:
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
        
        # Optional. At least one position must be provided
        "positions": [
            {
                "supply_id": int,   # Optional. ID of Supply model - required
                "accessory_id": int  # Optional. ID of Accessory model, if provided supply_id must be ommited
                "quantity": int,    # Optional. Defaults to 1, must be positive
            },
            # ... more positions
        ],
        
        # Optional. Accessory flag for order positions
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
    customer = None
    customer_email = data.get("customer_data", {}).get("email")
    billing_details = data.get("billing_details")
    billing_details_snapshot = None
    positions_data = data.get("positions", [])
    # Validate positions data
    if not positions_data:
        raise ValidationError("Order must have at least one position.")

    try:
        # 1. Step - Validate and handle billing details
        if not billing_details and not customer_email:
            raise ValidationError("At least, customer_email must be provided.")

        # Handle customer profile if customer_email is provided
        if user and user.is_authenticated:
            customer = user
        else:
            if not customer_email:
                raise ValidationError("Anonymous orders must include customer_email.")
            customer = UserModel.objects.check_and_create_anonymous_user(email=customer_email)
        
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
            order_notes=data.get("order_notes", ""),
        )
        order_positions = []
        total_order_price = 0

        # 3. Step - Create Order Positions and update stock2
        for pos_data in positions_data:
            supply_id = pos_data.get("supply_id")
            accessory_id = pos_data.get("accessory_id")

            if not supply_id and not accessory_id:
                raise ValidationError("Each position must have either 'supply_id' or 'accessory_id'.")
            if supply_id and accessory_id:
                raise ValidationError("Position cannot have both 'supply_id' and 'accessory_id'.")

            quantity = int(pos_data.get("quantity", 1))
            if quantity < 1:
                raise ValidationError("Quantity must be positive.")

            supply = None
            product = None
            accessory = None
            position_total = 0

            if supply_id:
                try:
                    supply = Supply.objects.select_for_update().get(pk=supply_id)
                except Exception as e:
                    raise ValidationError(f"Invalid supply_id {supply_id}: {str(e)}")

                if supply.quantity < quantity:
                    raise ValidationError(
                        f"Not enough stock for supply ID {supply_id}. "
                        f"Available: {supply.quantity}, requested: {quantity}."
                    )

                product = supply.product
                position_total = supply.price * quantity

                # update stock
                supply.quantity -= quantity
                supply.save()

            elif accessory_id:
                try:
                    accessory = Accessory.objects.get(pk=accessory_id)
                except Accessory.DoesNotExist:
                    raise ValidationError(f"Invalid accessory_id {accessory_id}.")

                if accessory.quantity < quantity:
                    raise ValidationError(
                        f"Not enough stock for accessory ID {accessory_id}. "
                        f"Available: {accessory.quantity}, requested: {quantity}."
                    )

                position_total = accessory.price * quantity

                # update stock
                accessory.quantity -= quantity
                accessory.save()

            total_order_price += position_total 

            order_positions.append(OrderPosition(
                order=order,
                product=product,
                accessory=accessory,
                quantity=quantity,
                total_price=position_total,
            ))

        # Bulk create order positions
        OrderPosition.objects.bulk_create(order_positions)

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
        
    if "status" in data:
        order.status = data["status"]

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