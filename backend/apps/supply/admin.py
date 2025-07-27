from django.contrib import admin
from apps.database_products.models import Supply


from .resources import SupplyResource
from import_export.admin import ImportExportModelAdmin


@admin.register(Supply)
class SupplyAdmin(ImportExportModelAdmin):
    resource_class = SupplyResource