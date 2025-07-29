from apps.products.models import Product
from apps.supply.models import Supply

from import_export import fields, resources, widgets


class SupplyResource(resources.ModelResource):
    product = fields.Field(
        attribute='products',
        column_name='SKU',
        widget=widgets.ForeignKeyWidget(Product, field='sku') 
    )
    serving_type = fields.Field(
        attribute='serving_type',
        column_name='Type'
    )
    price = fields.Field(
        attribute='price',
        column_name='Price'
    )
    quantity = fields.Field(
        attribute='quantity',
        column_name='Quantity',
        default=0
    )

    class Meta:
        model = Supply
        import_id_fields = ('products', 'serving_type', 'price')
        fields = ('products', 'serving_type', 'price', 'quantity')
