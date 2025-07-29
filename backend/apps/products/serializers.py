from rest_framework import serializers

from apps.supply.serializers import SupplySerializer

from ..database_products.models import Photo, Product


class PhotoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Photo
        fields = ['id', 'url']


class ProductSerializer(serializers.ModelSerializer):
    photos = PhotoSerializer(many=True, read_only=True)
    supplies = SupplySerializer(many=True, read_only=True)

    class Meta:
        model = Product
        fields = '__all__'