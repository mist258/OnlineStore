from rest_framework import serializers
from apps.basket.models import Basket, BasketItem, DiscountCode
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
            "discount_code",
        ]
        read_only_fields = ["user", "created_at", "updated_at"]
        
        
class DiscountCodeSerializer(serializers.ModelSerializer):
    is_valid = serializers.SerializerMethodField()
    apply_discount = serializers.SerializerMethodField()
    
    class Meta:
        model = DiscountCode
        fields = [
            "id",
            "code",
            "discount_percent",  # use this instead of 'amount'
            "valid_from",
            "valid_to",
            "is_valid"
            "apply_discount"
        ]
        read_only_fields = fields

    def get_is_valid(self, obj):
        """
        Returns True if the discount code is currently valid, else False.
        """
        return obj.is_valid()