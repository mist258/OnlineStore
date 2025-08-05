from django.db import models

from apps.products.models import Product


class Supply(models.Model):

    class Meta:
        db_table = "supply"
        ordering = ("id",)

    serving_type = models.CharField(max_length=50, blank=True)
    price = models.DecimalField(
        max_digits=8, 
        decimal_places=2, 
        default=0.00,
    )
    weight = models.DecimalField(
        max_digits=5, 
        decimal_places=2
    )
    quantity = models.IntegerField(default=0)
    product = models.ForeignKey(
        Product, 
        related_name='supplies',
        on_delete=models.CASCADE
    )

    def __str__(self):
        return f"{self.product.name} - {self.serving_type or 'No Serving-Type Info'}"