from rest_framework import serializers

from core.services.convert_currency_service import CurrencyService

from .models import Accessory, AccessoryPhotosModel


class AccessoryPhotoSerializer(serializers.ModelSerializer):
    """"
        serializer that allows to add photos to a product by uploading file from local machine
    """

    class Meta:
        model = AccessoryPhotosModel
        fields = ("id",
                  "photo",)


class AccessorySerializer(serializers.ModelSerializer):
    accessory_photos = AccessoryPhotoSerializer(many=True, read_only=True)
    converted_price = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = Accessory
        fields = ("id",
                  "name",
                  "sku",
                  "description",
                  "brand",
                  "price",
                  "converted_price",
                  "category",
                  "quantity",
                  "accessory_photos",
                  "is_special"
                  )

        read_only_fields = ("id","converted_price")

    def get_converted_price(self, obj):
        request = self.context.get("request")

        currency = "USD"
        if request:
            currency = request.query_params.get("currency", "USD")

        return CurrencyService.convert(
            price_usd=obj.price,
            to_currency=currency,
        )
