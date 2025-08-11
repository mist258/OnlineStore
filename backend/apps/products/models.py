from django.db import models

from apps.utils import get_timenow


class FlavorProfile(models.Model):

    class Meta:
        db_table = "flavor_profile"
        ordering = ("id",)

    name = models.CharField(max_length=100, null=False, unique=True)

    def __str__(self):
        return self.name


class Product(models.Model):

    class Meta:
        db_table = "product"
        ordering = ("id",)

    sku = models.CharField(max_length=50, unique=True, null=False)
    name = models.CharField(max_length=255, null=False)
    brend = models.CharField(max_length=255, null=False)
    caffeine_type = models.CharField(max_length=25, blank=True, null=False)
    sort = models.CharField(max_length=25, null=False, blank=True)
    roast = models.CharField(max_length=50)
    description = models.TextField(blank=True, null=False)

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
       related_name='photos',
       on_delete=models.CASCADE,
       null=True,
       blank=True
   )
   accessory = models.ForeignKey(
       Accessory,
       related_name='photos',
       on_delete=models.CASCADE,
       null=True,
       blank=True
   )

   def __str__(self):
       good = self.product or self.accessory
       return f"{self.url} (Good: {good.name if good else 'No Product/Accessory'})"