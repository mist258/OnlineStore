from rest_framework import serializers

from apps.accessories.serializers import AccessorySerializer
from apps.products.serializers import ProductSerializer
from apps.supplies.serializers import SupplySerializer

from .models import FavoriteItem, Favorites


class FavoriteItemSerializer(serializers.ModelSerializer):
    product_details = ProductSerializer(source='product', read_only=True)
    accessory_details = AccessorySerializer(source='accessory', read_only=True)
    supply_details = SupplySerializer(source='supply', read_only=True)
    
    class Meta:
        model = FavoriteItem
        fields = [
            'id',
            'favorites',
            'product',
            'product_details',
            'accessory',
            'accessory_details',
            'supply',
            'supply_details',
            'added_at'
        ]
        read_only_fields = ['added_at']

    def validate(self, data):
        """
        Check that at least one item type is provided
        """
        if not any([
            data.get('product'),
            data.get('accessory'),
            data.get('supply')
        ]):
            raise serializers.ValidationError(
                "At least one of product, accessory, or supply must be provided"
            )
        return data


class FavoritesSerializer(serializers.ModelSerializer):
    items = FavoriteItemSerializer(many=True, read_only=True)
    total_items = serializers.SerializerMethodField()

    class Meta:
        model = Favorites
        fields = [
            'id',
            'user',
            'items',
            'total_items',
            'created_at',
            'updated_at'
        ]
        read_only_fields = ['created_at', 'updated_at']

    def get_total_items(self, obj):
        """
        Get the total number of items in favorites
        """
        return obj.items.count()