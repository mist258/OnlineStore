from django.db import models

from apps.utils import get_timenow

from core.models import BaseModel
from core.services.photo_service import upload_product_photo

from .choices.product_choices import CaffeineLevelChoices, CoffeeBeanTypeChoices, RoastLevelChoices


class FlavorProfile(models.Model):

    class Meta:
        db_table = "flavor_profile"
        ordering = ("id",)

    name = models.CharField(max_length=30, null=True, blank=True)

    def __str__(self):
        return self.name


class Product(models.Model):

    class Meta:
        db_table = "product"
        ordering = ("id",)

    sku = models.CharField(max_length=50, unique=True)
    name = models.CharField(max_length=100, blank=True, null=True)
    brend = models.CharField(max_length=100, blank=True, null=True)
    caffeine_type = models.CharField(max_length=18,null=True, blank=True,
                                     choices=CaffeineLevelChoices.choices)
    sort = models.CharField(max_length=25, null=True, blank=True,
                            choices=CoffeeBeanTypeChoices.choices)
    roast = models.CharField(max_length=13, blank=True, null=True,
                             choices=RoastLevelChoices.choices)
    description = models.TextField(blank=True)

    flavor_profiles = models.ManyToManyField(
        FlavorProfile,
        related_name='products', blank=True
    )

    def __str__(self):
        return self.name


class Accessory(models.Model):
    class Meta:
        db_table = "products_accessory"
        ordering = ("id",)

    sku = models.CharField(max_length=50, unique=True, null=False)
    name = models.CharField(max_length=255)
    brand = models.CharField(max_length=100, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    price = models.DecimalField(max_digits=8, decimal_places=2, default=0.00)
    category = models.CharField(max_length=100, blank=True, null=True)
    quantity = models.PositiveIntegerField(default=0)

    def __str__(self):
        return f"{self.name} by {self.brand or 'Unknown Brand'}"
    
      
class Photo(models.Model):
   """
       model for adding photos to a product by a url
   """

   class Meta:
        db_table = "photo"
        ordering = ("id",)

   url = models.CharField(
       max_length=255,
       null=True,
       default=get_timenow
   )
   position = models.IntegerField(default=0)
   product = models.ForeignKey(
       Product,
       related_name='photos_url',
       on_delete=models.CASCADE
   )
   accessory = models.ForeignKey(
       Accessory,
       related_name='photos_url',
       on_delete=models.CASCADE,
       null=True,
       blank=True
   )
   def __str__(self):
       return f"{self.url} (Product: {self.product.name})"


class PhotosModel(BaseModel):
    """
        model for adding photos to a product without using a url,
        but from the local machine
    """
    class Meta:
        db_table = "product_photo"
        ordering = ("id",)

    photo = models.ImageField(upload_to=upload_product_photo, blank=True)
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="product_photos")
    