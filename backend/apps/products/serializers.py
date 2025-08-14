from rest_framework import serializers

from apps.products.models import Accessory, Photo, Product
from apps.supply.serializers import SupplySerializer


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
        

class AccessorySerializer(serializers.ModelSerializer):
    photos = PhotoSerializer(many=True, read_only=True)
    
    class Meta:
        model = Accessory
        fields = ['id', 'sku', 'name', 'brand', 'description', 'price', 'category', 'quantity']