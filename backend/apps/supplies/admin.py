from django.contrib import admin

from apps.supplies.models import Supply

from import_export.admin import ImportExportModelAdmin

from .resources import SupplyResource


@admin.register(Supply)
class SupplyAdmin(ImportExportModelAdmin):
    resource_class = SupplyResource