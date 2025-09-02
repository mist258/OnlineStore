from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction
from backend.apps.db_utils import get_object_or_error

from apps.basket.models import Basket, BasketItem
from apps.products.models import Product


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