from django.contrib import admin

from import_export.admin import ImportExportModelAdmin

from .models import Accessory
from .resources import AccessoryResource


@admin.register(Accessory)
class AccessoryAdmin(ImportExportModelAdmin):
    resource_class = AccessoryResource
    list_display = ('name', 'brand', 'id', 'price', 'category', 'quantity')