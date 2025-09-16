from decimal import Decimal

from django.core import validators as v
from django.db import models


class Accessory(models.Model):
    class Meta:
        db_table = "products_accessory"
        ordering = ("id",)

    sku = models.CharField(max_length=50, unique=True)
    name = models.CharField(max_length=255)
    brand = models.CharField(max_length=100, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    price = models.DecimalField(max_digits=8, decimal_places=2,
                                validators=[v.MinValueValidator(Decimal("0.00"))])
    category = models.CharField(max_length=100, blank=True, null=True)
    quantity = models.PositiveIntegerField(blank=False,
                                           validators=[v.MinValueValidator(0)])

    def __str__(self):
        return f"{self.name} by {self.brand or 'Unknown Brand'}"