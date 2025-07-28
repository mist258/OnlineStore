from django.contrib import admin
from import_export.admin import ImportExportModelAdmin

from apps.supply.models import Supply
from apps.supply.resources import SupplyResource


@admin.register(Supply)
class SupplyAdmin(ImportExportModelAdmin):
    resource_class = SupplyResource