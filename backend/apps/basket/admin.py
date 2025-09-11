from django.contrib import admin

from apps.basket.models import Basket, BasketItem


admin.site.register(Basket)

admin.site.register(BasketItem)
