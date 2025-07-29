from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.order.models import Order, OrderPosition
from apps.products.models import Product

from backend.apps.db_utils import get_object_or_error


@transaction.atomic
def create_order_position(data: dict) -> OrderPosition:
    quantity = data.get("quantity", 1)
    product_id = data.get("product_id")
    order_id = data.get("order_id")

    if product_id is None:
        raise ValidationError("OrderPosition 'product_id' is required.")
    if order_id is None:
        raise ValidationError("OrderPosition 'order_id' is required.")

    product = get_object_or_error(Product, product_id)
    order = get_object_or_error(Order, order_id)

    try:
        position = OrderPosition.objects.create(
            quantity=quantity,
            product=product,
            order=order
        )
    except IntegrityError as e:
        raise ValidationError(f"Database error during order position creation: {str(e)}")
    except Exception as e:
        raise ValidationError(f"Unexpected error: {str(e)}")

    return position


def get_order_position_by_id(position_id: int) -> OrderPosition:
    return get_object_or_error(OrderPosition, position_id)


@transaction.atomic
def update_order_position(position_id: int, data: dict) -> OrderPosition:
    position = get_object_or_error(OrderPosition, position_id)

    if "quantity" in data:
        position.quantity = data["quantity"]
    if "product_id" in data:
        position.product = get_object_or_error(Product, data["product_id"])
    if "order_id" in data:
        position.order = get_object_or_error(Order, data["order_id"])

    position.save()
    return position


@transaction.atomic
def delete_order_position(position_id: int) -> None:
    position = get_object_or_error(OrderPosition, position_id)

    try:
        position.delete()
    except OrderPosition.DoesNotExist:
        raise ValueError(f"OrderPosition with id {position_id} not found.")
    except IntegrityError as e:
        raise ValueError(f"Cannot delete order position {position_id}: {str(e)}")
