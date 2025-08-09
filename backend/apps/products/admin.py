from django.contrib import admin

from apps.products.models import Photo, Product, Accessory

from import_export.admin import ImportExportModelAdmin

from .resources import PhotoResource, ProductResource, AccessoryResource


@admin.register(Product)
class ProductAdmin(ImportExportModelAdmin):
    resource_class = ProductResource


@admin.register(Photo)
class PhotoAdmin(ImportExportModelAdmin):
    resource_class = PhotoResource
    def generate_log_entries(self, *args, **kwargs):
        pass
    
    
@admin.register(Accessory)
class AccessoryAdmin(ImportExportModelAdmin):
    resource_class = AccessoryResource