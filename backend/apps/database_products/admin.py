# from django.contrib import admin
#
# from apps.database_products.models import (  # BillingDetails,
#     Customer,
#     FlavorProfile,
#     Order,
#     OrderPosition,
#     Photo,
#     Product,
#     Review,
#     Subscription,
#     Supply,
# )
#
# from import_export.admin import ImportExportModelAdmin
#
# from .resources import PhotoResource, ProductResource, SupplyResource
#
# #admin.site.register(Product)
# admin.site.register(FlavorProfile)
# #admin.site.register(Supply)
# #admin.site.register(Photo)
# admin.site.register(Review)
# admin.site.register(Order)
# admin.site.register(OrderPosition)
# admin.site.register(Customer)
# admin.site.register(Subscription)
#
#
# @admin.register(Product)
# class ProductAdmin(ImportExportModelAdmin):
#     resource_class = ProductResource
#
#
# @admin.register(Supply)
# class SupplyAdmin(ImportExportModelAdmin):
#     resource_class = SupplyResource
#
#
# @admin.register(Photo)
# class PhotoAdmin(ImportExportModelAdmin):
#     resource_class = PhotoResource
#     def generate_log_entries(self, *args, **kwargs):
#         pass