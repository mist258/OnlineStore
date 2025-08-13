from django.db import models


class GrindTypeChoices(models.TextChoices):
    SOLUBLE = "soluble", "Soluble"
    GROUND = "ground", "Ground"
    GRAINS = "grains", "In grains"
    CAPSULES = "capsules", "In capsules"


class CoffeeBeanTypeChoices(models.TextChoices):
    ARABICA = "arabica", "100% Arabica"
    ROBUSTA = "robusta", "100% Robusta"
    ARABICA_ROBUSTA = "arabica_robusta", "Arabica/Robusta Blend"


class RoastLevelChoices(models.TextChoices):
    LIGHT = "light", "Light Roast"
    MEDIUM = "medium", "Medium Roast"
    DARK = "dark", "Dark Roast"


class CaffeineLevelChoices(models.TextChoices):
    REGULAR = "regular", "Regular"
    DECAF = "decaf", "Decaf"
