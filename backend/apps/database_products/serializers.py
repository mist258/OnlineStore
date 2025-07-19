from rest_framework import serializers
from .models import Product, Photo, Supply

class PhotoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Photo
        fields = ['id', 'url']

class SupplySerializer(serializers.ModelSerializer):
    class Meta:
        model = Supply
        fields = ['id', 'serving_type', 'price']

class ProductSerializer(serializers.ModelSerializer):
    photos = PhotoSerializer(many=True, read_only=True)
    supplies = SupplySerializer(many=True, read_only=True)

    class Meta:
        model = Product
        fields = '__all__'