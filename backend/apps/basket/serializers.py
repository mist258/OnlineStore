from rest_framework import serializers
from apps.basket.models import Basket, BasketItem
from apps.products.models import Product


class BasketItemSerializer(serializers.ModelSerializer):
    product_name = serializers.CharField(source="product.name", read_only=True)
    accessory_name = serializers.CharField(source="accessory.name", read_only=True)
    total_price = serializers.DecimalField(
        max_digits=10, decimal_places=2, read_only=True
    )

    class Meta:
        model = BasketItem
        fields = [
            "id",
            "product",
            "product_name",
            "accessory_name",
            "quantity",
            "total_price",
        ]


class BasketSerializer(serializers.ModelSerializer):
    items = BasketItemSerializer(many=True, read_only=True)
    total_price = serializers.DecimalField(
        max_digits=10, decimal_places=2, read_only=True
    )

    class Meta:
        model = Basket
        fields = [
            "id",
            "user",
            "guest_token",
            "is_active",
            "created_at",
            "updated_at",
            "items",
            "total_price",
        ]
        read_only_fields = ["user", "created_at", "updated_at"]