from django.db.models import F, Sum
from decimal import Decimal

from django.db import models
from django.conf import settings


from apps.products.models import Product, Accessory
from apps.supplies.models import Supply

class Basket(models.Model):
    """
    Represents a user's shopping basket (cart).
    """
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="baskets",
        null=True, blank=True  # allow guest baskets if needed
    )
    guest_token = models.UUIDField(null=True, blank=True, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(default=True)  # useful to deactivate once converted to Order

    def __str__(self):
        return f"Basket {self.id} for {self.user}"
    
    @property
    def total_price(self):
        result = self.items.aggregate(
            total=Sum(F("quantity") * F("product__price"))
        )
        return result["total"] or Decimal("0.00")


class BasketItem(models.Model):
    """
    Items inside the shopping basket.
    """
    basket = models.ForeignKey(
        Basket,
        on_delete=models.CASCADE,
        related_name="items"
    )
    accessory = models.ForeignKey(
        Accessory,
        on_delete=models.CASCADE,
        related_name="basket_items",
        null=True,
        blank=True
    )
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE
    )
    supply = models.ForeignKey(
        Supply,
        related_name='basket_items',
        null=True,
        blank=True,
        on_delete=models.CASCADE
    )
    quantity = models.PositiveIntegerField(default=1)

    class Meta:
        unique_together = ("basket", "product")
    def __str__(self):
        return f"{self.quantity} x {self.product} in Basket {self.basket.id}"

    @property
    def total_price(self):
        if self.accessory:
            return self.accessory.price * self.quantity
        return self.supply.price * self.quantity
