from django.db.models import F, Sum
from decimal import Decimal

from django.db import models
from django.conf import settings


from apps.products.models import Product, Accessory
from apps.supplies.models import Supply
from django.utils import timezone


class DiscountCode(models.Model):
    """
    Represents a discount code that can be applied to a basket.
    """
    code = models.CharField(max_length=50, unique=True)
    description = models.TextField(blank=True)
    discount_percent = models.DecimalField(max_digits=5, decimal_places=2)
    active = models.BooleanField(default=True)
    valid_from = models.DateTimeField(blank=True, null=True)
    valid_to = models.DateTimeField(blank=True, null=True)

    def __str__(self):
        return self.code

    def is_valid(self):
        now = timezone.now()
        return self.active and self.valid_from <= now <= self.valid_to

    def apply_discount(self, amount):
        if not self.is_valid():
            return amount
        discount_amount = (self.discount_percent / Decimal('100.00')) * amount
        return amount - discount_amount
    
    
class Basket(models.Model):
    """
    Represents a user's shopping basket (cart).
    """
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="baskets",
        null=True, blank=True
    )
    discount_code = models.ForeignKey(
        DiscountCode,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="baskets"
    )
    guest_token = models.UUIDField(null=True, blank=True, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(default=True)
    

    def __str__(self):
        return f"Basket {self.id} for {self.user}"
    
    @property
    def total_price(self):
        return sum(item.total_price for item in self.items.all())


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
        on_delete=models.CASCADE,
        related_name="basket_items",
        null=True,
        blank=True
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
        constraints = [
            models.UniqueConstraint(
                fields=['basket', 'product', 'accessory', 'supply'],
                name='unique_basket_item'
            )
        ]
        
    def __str__(self):
        return f"{self.quantity} x {self.product or self.accessory} in Basket {self.basket.id}"

    @property
    def total_price(self):
        if self.accessory:
            return self.accessory.price * self.quantity
        return self.supply.price * self.quantity


