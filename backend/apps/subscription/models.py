from django.db import models


class Subscription(models.Model):

    class Meta:
        db_table = "services"
        ordering = ("id",)

    name = models.CharField(max_length=100)
    letter = models.CharField(max_length=100)

    def __str__(self):
        return self.name