from django.db import models

from apps.accessories.models import Accessory
from apps.utils import get_timenow

from core.models import BaseModel
from core.services.photo_service import PhotoService

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

    sku = models.CharField(max_length=50, unique=True, null=False)
    name = models.CharField(max_length=100, blank=True, null=True)
    brand = models.CharField(max_length=100, blank=True, null=True)
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
       on_delete=models.CASCADE,
       null=True,
       blank=True
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


class ProductPhotosModel(BaseModel):
    """
        model for adding photos to a product without using a url,
        but from the local machine
    """
    class Meta:
        db_table = "products_photo"
        ordering = ("id",)

    photo = models.ImageField(upload_to=PhotoService.upload_product_photo, blank=True)
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="product_photos")

    