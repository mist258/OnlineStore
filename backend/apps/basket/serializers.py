from rest_framework import serializers
from apps.basket.models import Basket, BasketItem
from apps.products.models import Product


class BasketItemSerializer(serializers.ModelSerializer):
    product_name = serializers.CharField(source="product.name", read_only=True)
    product_price = serializers.DecimalField(source="product.price", read_only=True, max_digits=10, decimal_places=2)
    total_price = serializers.SerializerMethodField()

    class Meta:
        model = BasketItem
        fields = [
            "id",
            "product",
            "product_name",
            "product_price",
            "quantity",
            "total_price",
        ]

    def get_total_price(self, obj):
        return obj.total_price


class BasketSerializer(serializers.ModelSerializer):
    items = BasketItemSerializer(many=True, read_only=True)
    total_price = serializers.SerializerMethodField()

    class Meta:
        model = Basket
        fields = [
            "id",
            "user",
            "is_active",
            "created_at",
            "updated_at",
            "items",
            "total_price",
        ]
        read_only_fields = ["user", "created_at", "updated_at"]

    def get_total_price(self, obj):
        return sum(item.total_price for item in obj.items.all())
