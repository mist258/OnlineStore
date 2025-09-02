from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction
from backend.apps.db_utils import get_object_or_error

from apps.basket.models import Basket, BasketItem
from apps.products.models import Product


@transaction.atomic
def add_product_to_basket(basket_id: int, product_id: int, quantity: int = 1) -> BasketItem:
    if basket_id is None or product_id is None:
        raise ValidationError("Both 'basket_id' and 'product_id' are required.")

    basket = get_object_or_error(Basket, id=basket_id)
    product = get_object_or_error(Product, id=product_id)

    try:
        item, created = BasketItem.objects.get_or_create(
            basket=basket,
            product=product,
            defaults={"quantity": quantity}
        )
        if not created:
            item.quantity += quantity
            item.save()
    except IntegrityError as e:
        raise ValidationError(f"Database error during basket item creation: {str(e)}")

    return item


@transaction.atomic
def remove_product_from_basket(item_id: int) -> None:
    item = get_object_or_error(BasketItem, id=item_id)
    item.delete()


def get_basket_total(basket_id: int) -> float:
    basket = get_object_or_error(Basket, id=basket_id)
    return sum(item.product.price * item.quantity for item in basket.items.all())