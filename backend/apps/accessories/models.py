from decimal import Decimal

from django.core import validators as v
from django.db import models

from core.models import BaseModel
from core.services.photo_service import PhotoService


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


class AccessoryPhotosModel(BaseModel):
    """
        model for adding photos to a product without using a url,
        but from the local machine
    """
    class Meta:
        db_table = "accessory_photo"
        ordering = ("id",)

    photo = models.ImageField(upload_to=PhotoService.upload_product_photo, blank=True)
    accessory = models.ForeignKey(Accessory, on_delete=models.CASCADE, related_name="accessory_photos")