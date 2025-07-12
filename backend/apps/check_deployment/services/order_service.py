from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.check_deployment.db_utils import get_object_or_error
from apps.check_deployment.models import Order, Customer


@transaction.atomic
def create_order(data: dict) -> Order:
    customer_id = data.get("customer_id")
    if customer_id is None:
        raise ValidationError("Order 'customer_id' field is required.")

    customer = get_object_or_error(Customer, customer_id)

    try:
        order = Order.objects.create(
            customer=customer,
            order_notes=data.get("order_notes")
        )
    except IntegrityError as e:
        raise ValidationError(f"Database error during order creation: {str(e)}")
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

    if "customer_id" in data:
        customer = get_object_or_error(Customer, data["customer_id"])
        order.customer = customer

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
        raise ValueError(f"Cannot delete order {order_id}: {str(e)}")
