from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction
from django.db.models import F

from apps.db_utils import get_object_or_error
from apps.orders.models import Order, OrderPosition
from apps.users.models import UserModel


@transaction.atomic
def create_order_from_basket(*, customer, basket, billing_data, discount_code, currency='USD', notes=None) -> Order:
        order = Order.objects.create(
            customer=customer,
            order_notes=notes,
            discount_code=discount_code,
            currency=currency,
            **billing_data,
        )

        for item in basket.items.select_related(
            "product",
            "accessory",
            "supply"
        ):
            price = 0

            if item.product:
                supplies = item.supply
                price = supplies.price
                
                if supplies.quantity < item.quantity:
                    raise ValidationError(
                        f"Not enough stock for {item}"
                    )
                
                supplies.quantity = F("quantity") - item.quantity
                supplies.save(update_fields=["quantity"])
            else:
                accessory = item.accessory
                price = accessory.price
                
                if accessory.quantity < item.quantity:
                    raise ValidationError(
                        f"Not enough stock for {item}"
                    )
                
                accessory.quantity = F("quantity") - item.quantity
                accessory.save(update_fields=["quantity"])

            position = OrderPosition.objects.create(
                order=order,
                product=item.product,
                accessory=item.accessory,
                quantity=item.quantity
            )

            # setting the price field
            position.price = price
            position.save(update_fields=["price"])
            
        basket.items.all().delete()

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