from uuid import uuid4

from apps.products.models import Photo, Product, Accessory

from import_export import fields, resources, widgets
from import_export.results import RowResult


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


class PhotoResource(resources.ModelResource):
    # Using ForeignKeyWidget to associate photos with either a Product or Accessory
    product = fields.Field(
        attribute='product',
        column_name='Name',
        widget=widgets.ForeignKeyWidget(Product, 'name')
    )
    accessory = fields.Field(
        attribute='accessory',
        column_name='Accessory Name',
        widget=widgets.ForeignKeyWidget(Accessory, 'name')
    )
    photos = fields.Field(
        column_name='Photos',
        attribute='url'
    )

    class Meta:
        model = Photo
        import_id_fields = ('photos',)
        fields = ('photos', 'position', 'product', 'accessory')

    def import_row(self, row, instance_loader, **kwargs):
        result = RowResult()
        result.import_type = RowResult.IMPORT_TYPE_NEW
        result.errors = []

        # Try to find Product or Accessory by name
        product_name = row.get('Name')
        accessory_name = row.get('Accessory Name')
        photos_field = row.get('Photos', '')

        # Try to find the product first
        product = None
        if product_name:
            product = Product.objects.filter(name=product_name).first()

        # Then try to find the accessory if no product is found
        accessory = None
        if not product and accessory_name:
            accessory = Accessory.objects.filter(name=accessory_name).first()

        if not product and not accessory:
            result.import_type = RowResult.IMPORT_TYPE_SKIP
            result.object_repr = f"Skipped – No product or accessory found for '{product_name or accessory_name}'"
            result.diff = [("name", product_name or accessory_name)]
            
            # Creating dummy photo if no matching Product or Accessory
            dummy_photo = Photo(url=f"dummy_{uuid4()}.jpg")
            result.object = dummy_photo
            return result

        # Split photos and associate them with the correct object
        photo_urls = [p.strip() for p in photos_field.split(';') if p.strip()]
        diff_list = []
        last_photo_obj = None

        for idx, url in enumerate(photo_urls):
            if product:
                photo_obj, created = Photo.objects.update_or_create(
                    url=url,
                    product=product,
                    defaults={'position': idx}
                )
            elif accessory:
                photo_obj, created = Photo.objects.update_or_create(
                    url=url,
                    accessory=accessory,
                    defaults={'position': idx}
                )

            last_photo_obj = photo_obj
            diff_list.extend([
                ("url", url),
                ("position", idx),
                ("product", product.name if product else ""),
                ("accessory", accessory.name if accessory else "")
            ])

        result.object_repr = f"{len(photo_urls)} photos for '{product.name if product else accessory.name}'"
        result.diff = diff_list
        result.object = last_photo_obj or Photo(url=f"dummy_{uuid4()}.jpg")
        return result
    
    
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