from django.db import models


class ServingTypeChoices(models.TextChoices):
    SOLUBLE = "Soluble", "Soluble"
    GROUND = "Ground", "Ground"
    IN_GRAINS = "In grains", "In grains"
    CAPSULES = "In capsules", "In capsules"