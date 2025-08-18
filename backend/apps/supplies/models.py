from django.db import models

from apps.products.models import Product

from .choices.supply_choices import ServingTypeChoices


class Supply(models.Model):

    class Meta:
        db_table = "supplies"
        ordering = ("id",)

    serving_type = models.CharField(choices=ServingTypeChoices.choices, blank=True, null=True,)
    price = models.DecimalField(
        max_digits=8, decimal_places=2,
        default=0.00, null=True, blank=True
    )
    weight = models.DecimalField(
        max_digits=5, decimal_places=2,
        null=True, blank=True,
    )
    quantity = models.IntegerField(default=0, null=True, blank=True)
    product = models.ForeignKey(
        Product, 
        related_name='supplies',
        on_delete=models.CASCADE,
        null=True, 
        blank=True
    )

    def __str__(self):
        return f"{self.product.name} - {self.serving_type or 'No Serving-Type Info'}"