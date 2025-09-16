from import_export import fields, resources

from .models import Accessory


class AccessoryResource(resources.ModelResource):
    sku = fields.Field(
        attribute='sku',
        column_name='SKU'
    )
    name = fields.Field(
        attribute='name',
        column_name='Accessory Name'
    )
    brand = fields.Field(
        attribute='brand',
        column_name='Brand'
    )
    description = fields.Field(
        attribute='description',
        column_name='Description'
    )
    price = fields.Field(
        attribute='price',
        column_name='Price'
    )
    quantity = fields.Field(
        attribute='quantity',
        column_name='Quantity'
    )

    class Meta:
        model = Accessory
        import_id_fields = ('sku',)
        fields = (
            'sku',
            'name',
            'brand',
            'description',
            'price',
            'quantity',
        )