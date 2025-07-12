from django.contrib import admin
from apps.check_deployment.models import (
    Product, 
    FlavorProfile, 
    Supply, 
    Photo, 
    Subscription, 
    Customer, 
    Review, 
    Order, 
    OrderPosition, 
    BillingDetails
)

admin.site.register(Product)
admin.site.register(FlavorProfile)
admin.site.register(Supply)
admin.site.register(Photo)
admin.site.register(Review)
admin.site.register(Order)
admin.site.register(OrderPosition)
admin.site.register(Customer)
admin.site.register(BillingDetails)
admin.site.register(Subscription)
