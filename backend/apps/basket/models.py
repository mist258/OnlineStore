from django.db import models
from django.conf import settings

from apps.products.models import Product

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
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(default=True)  # useful to deactivate once converted to Order

    def __str__(self):
        return f"Basket {self.id} for {self.user}"


class BasketItem(models.Model):
    """
    Items inside the shopping basket.
    """
    basket = models.ForeignKey(
        Basket,
        on_delete=models.CASCADE,
        related_name="items"
    )
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE
    )
    quantity = models.PositiveIntegerField(default=1)

    class Meta:
        unique_together = ("basket", "product")  # no duplicate products

    def __str__(self):
        return f"{self.quantity} x {self.product} in Basket {self.basket.id}"

    @property
    def total_price(self):
        return self.product.price * self.quantity
