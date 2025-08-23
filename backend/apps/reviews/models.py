from django.contrib.auth import get_user_model
from django.core import validators as v
from django.db import models

from apps.products.models import Product

from core.models import BaseModel

UserModel = get_user_model()


class Review(BaseModel):
    class Meta:
        db_table = "reviews"
        ordering = ("-created_at",)

    grade = models.IntegerField(validators=[v.MinValueValidator(1), v.MaxValueValidator(5)])
    comment = models.TextField(blank=True, null=True)
    customer = models.ForeignKey(
        UserModel,
        on_delete=models.CASCADE,
        related_name='reviews'
    )

    def __str__(self):
        return f"Review {self.grade} ★ by {self.customer.email}"