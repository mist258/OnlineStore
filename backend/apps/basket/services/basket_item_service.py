from django.db import transaction

from apps.basket.models import BasketItem
from apps.products.models import Product

from backend.apps.db_utils import get_object_or_error


def get_basket_item(item_id: int) -> BasketItem:
    return get_object_or_error(BasketItem, id=item_id)


@transaction.atomic
def update_basket_item(item_id: int, data: dict) -> BasketItem:
    item = get_object_or_error(BasketItem, id=item_id)

    if "quantity" in data:
        item.quantity = data["quantity"]
    if "product_id" in data:
        item.product = get_object_or_error(Product, id=data["product_id"])

    item.save()
    return item