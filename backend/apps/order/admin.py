from django.contrib import admin

from apps.order.models import Order, OrderPosition

admin.site.register(Order)

admin.site.register(OrderPosition)