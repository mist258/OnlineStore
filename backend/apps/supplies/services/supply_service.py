from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.products.models import Product
from apps.supplies.models import Supply

from backend.apps.db_utils import get_object_or_error


@transaction.atomic
def create_supply(data: dict) -> Supply:
    product_id = data.get("product_id")
    if not product_id:
        raise ValidationError("Supply must have a product_id.")

    product = get_object_or_error(Product, product_id)

    try:
        supply = Supply.objects.create(
            product=product,
            serving_type=data.get("serving_type"),
            price=data.get("price", 0.00),
            weight=data.get("weight"),
            quantity=data.get("quantity", 0),
        )
    except IntegrityError as e:
        raise ValidationError(f"Database error during supplies creation: {str(e)}")
    except Exception as e:
        raise ValidationError(f"Unexpected error: {str(e)}")

    return supply


def get_supply_by_id(supply_id: int) -> Supply:
    return get_object_or_error(Supply, supply_id)


@transaction.atomic
def update_supply(supply_id: int, data: dict) -> Supply:
    supply = get_object_or_error(Supply, supply_id)

    supply.serving_type = data.get("serving_type", supply.serving_type)
    supply.price = data.get("price", supply.price)
    supply.weight = data.get("weight", supply.weight)
    supply.quantity = data.get("quantity", supply.quantity)

    if "product_id" in data:
        new_product = get_object_or_error(Product, data["product_id"])
        supply.product = new_product

    supply.save()
    return supply


@transaction.atomic
def delete_supply(supply_id: int) -> None:
    supply = get_object_or_error(Supply, supply_id)

    try:
        supply.delete()
    except Supply.DoesNotExist:
        raise ValueError(f"Supply with id {supply_id} not found.")
    except IntegrityError as e:
        raise ValueError(f"Cannot delete supplies {supply_id}: {str(e)}")
