from rest_framework import serializers

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

    class Meta:
        model = Accessory
        fields = ("id",
                  "name",
                  "sku",
                  "description",
                  "brand",
                  "price",
                  "category",
                  "quantity",
                  "accessory_photos",
                  "is_special"
                  )

        read_only_fields = ("id",)
