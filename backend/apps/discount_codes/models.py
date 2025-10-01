from decimal import Decimal

from django.db import models
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
    