from django.db import models


class ServingTypeChoices(models.TextChoices):
    SOLUBLE = "soluble", "Soluble"
    GROUND = "ground", "Ground"
    IN_GRAINS = "Grains", "In grains"
    CAPSULES = "capsules", "In capsules"