from django.db import models
from apps.subscription.models import Subscription


class Customer(models.Model):
    email = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=255, blank=True, null=True)
    is_guest = models.BooleanField(default=True)

    subscriptions = models.ManyToManyField(
        Subscription, 
        related_name='customers', 
        blank=True
    )

    def __str__(self):
        return self.email