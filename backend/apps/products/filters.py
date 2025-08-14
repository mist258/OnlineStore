from apps.products.choices.product_choices import CaffeineLevelChoices, CoffeeBeanTypeChoices, RoastLevelChoices
from apps.supplies.choices.supply_choices import ServingTypeChoices

from django_filters import rest_framework as filters

from .models import Product


class CoffeeProductFilter(filters.FilterSet):

    class Meta:
        model = Product
        fields = ("name",
                  "brend",
                  "roast",
                  "sort",
                  "caffeine_type")

    # search in choices
    grind_type = filters.MultipleChoiceFilter(field_name='supplies__serving_type', choices=ServingTypeChoices)
    roast_level = filters.MultipleChoiceFilter(field_name='roast', choices=RoastLevelChoices)
    caffeine_content = filters.MultipleChoiceFilter(field_name='caffeine_type', choices=CaffeineLevelChoices)
    coffee_bean_type = filters.MultipleChoiceFilter(field_name='sort', choices=CoffeeBeanTypeChoices)
    price_range = filters.RangeFilter(field_name='supplies__price')

