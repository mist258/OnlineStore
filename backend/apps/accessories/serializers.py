from rest_framework import serializers

from apps.products.serializers import PhotoSerializer

from .models import Accessory


class AccessorySerializer(serializers.ModelSerializer):
    photos = PhotoSerializer(many=True, read_only=True)

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
                  "photos")

        read_only_fields = ("id",)
