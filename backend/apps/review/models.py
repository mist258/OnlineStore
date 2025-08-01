from django.contrib.auth import get_user_model
from django.db import models

from apps.products.models import Product
from apps.utils import get_timenow

UserModel = get_user_model()


class Review(models.Model):
    class Meta:
        db_table = "review"
        ordering = ("-id",)

    grade = models.IntegerField()
    date = models.DateField(default=get_timenow)
    comment = models.TextField(blank=True, null=True)
    customer = models.ForeignKey(
        UserModel,
        on_delete=models.CASCADE,
        related_name='reviews'
    )
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        related_name='reviews'
    )

    def __str__(self):
        return f"Review {self.grade} ★ by {self.customer.email}"