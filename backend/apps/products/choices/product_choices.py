from django.db import models


class CoffeeBeanTypeChoices(models.TextChoices):
    ARABICA = "Arabica", "Arabica"
    ROBUSTA = "Robusta", "Robusta"
    ARABICA_ROBUSTA = "Arabica/robusta blend", "Arabica/robusta blend"


class RoastLevelChoices(models.TextChoices):
    LIGHT = "light", "Light Roast"
    MEDIUM = "medium", "Medium Roast"
    DARK = "dark", "Dark Roast"


class CaffeineLevelChoices(models.TextChoices):
    CAFFEINE = "Caffeine", "Caffeine"
    CAFFEINE_MEDIUM = "Caffeine Medium", "Caffeine Medium"
    DECAFFEINATED = "Decaffeinated", "Decaffeinated"
