from django.contrib import admin
from import_export.admin import ImportExportModelAdmin

from apps.product.models import Photo, Product
from apps.product.resources import PhotoResource, ProductResource


@admin.register(Product)
class ProductAdmin(ImportExportModelAdmin):
    resource_class = ProductResource


@admin.register(Photo)
class PhotoAdmin(ImportExportModelAdmin):
    resource_class = PhotoResource
    def generate_log_entries(self, *args, **kwargs):
        pass