from import_export import resources, fields, widgets
from apps.database_products.models import Product, Supply, Photo
from import_export.results import RowResult
from uuid import uuid4


class ProductResource(resources.ModelResource):
    sku = fields.Field(
        attribute='sku',
        column_name='SKU'
    )
    name = fields.Field(
        attribute='name',
        column_name='Name'
    )
    brend = fields.Field(
        attribute='brend',
        column_name='Brend'
    )
    sort = fields.Field(
        attribute='sort',
        column_name='Sort'
    )
    roast = fields.Field(
        attribute='roast',
        column_name='Roast'
    )
    caffeine_type = fields.Field(
        attribute='caffeine_type',
        column_name='Caffeine/Decaffeinated'
    )

    class Meta:
        model = Product
        import_id_fields = ('sku',)
        fields = (
            'name', 
            'brend', 
            'sort', 
            'roast', 
            'caffeine_type', 
            'sku'
        )


class SupplyResource(resources.ModelResource):
    product = fields.Field(
        attribute='product',  
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

    class Meta:
        model = Supply
        import_id_fields = ('product', 'serving_type', 'price')
        fields = ('product', 'serving_type', 'price',)


class PhotoResource(resources.ModelResource):
    product = fields.Field(
        attribute='product',
        column_name='Name',
        widget=widgets.ForeignKeyWidget(Product, 'name')
    )
    photos = fields.Field(
        column_name='Photos',
        attribute='url'
    )

    class Meta:
        model = Photo
        import_id_fields = ('photos', 'product')
        fields = ('photos', 'position', 'product')

    def import_row(self, row, instance_loader, **kwargs):
        result = RowResult()
        result.import_type = RowResult.IMPORT_TYPE_NEW
        result.errors = []

        product_name = row.get('Name')
        photos_field = row.get('Photos', '')
        product = Product.objects.filter(name=product_name).first()
        if not product:
            result.import_type = RowResult.IMPORT_TYPE_SKIP
            result.object_repr = f"Skipped – No product: {product_name}"
            result.diff = [("product", product_name)]
            
            dummy_photo = Photo(url=f"dummy_{uuid4()}.jpg")
            result.object = dummy_photo
            return result

        photo_urls = [p.strip() for p in photos_field.split(';') if p.strip()]
        diff_list = []
        last_photo_obj = None

        for idx, url in enumerate(photo_urls):
            photo_obj, created = Photo.objects.update_or_create(
                url=url,
                product=product,
                defaults={'position': idx}
            )
            last_photo_obj = photo_obj
            diff_list.extend([
                ("url", url),
                ("position", idx),
                ("product", product.name)
            ])

        result.object_repr = f"{len(photo_urls)} photos for '{product.name}'"
        result.diff = diff_list
        result.object = last_photo_obj or Photo(url=f"dummy_{uuid4()}.jpg", product=product)
        return result