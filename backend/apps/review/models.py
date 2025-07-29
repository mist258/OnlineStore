from django.db import models

from apps.customer.models import Customer
from apps.products.models import Product
from apps.utils import get_timenow


class Review(models.Model):
    class Meta:
        db_table = "review"
        ordering = ("-id",)

    grade = models.IntegerField()
    date = models.DateField(default=get_timenow)
    comment = models.TextField(blank=True, null=True)
    customer = models.ForeignKey(
        Customer,
        on_delete=models.CASCADE,
        related_name='reviews'
    )
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        related_name='reviews'
    )

    def __str__(self):
        return f"Review {self.grade}★ by {self.customer.email}"