from django.contrib import admin
from apps.product.models import (
    Product,
    Photo,
)

from .resources import ProductResource, PhotoResource
from import_export.admin import ImportExportModelAdmin


@admin.register(Product)
class ProductAdmin(ImportExportModelAdmin):
    resource_class = ProductResource


@admin.register(Photo)
class PhotoAdmin(ImportExportModelAdmin):
    resource_class = PhotoResource
    def generate_log_entries(self, *args, **kwargs):
        pass