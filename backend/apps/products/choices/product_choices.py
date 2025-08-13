from django.db import models


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
