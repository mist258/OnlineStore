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
       on_delete=models.CASCADE
   )

   def __str__(self):
       return f"{self.url} (Product: {self.product.name})"