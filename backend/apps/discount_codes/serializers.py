from rest_framework import serializers

from apps.basket.models import DiscountCode


class DiscountCodesSerializer(serializers.ModelSerializer):
    is_valid = serializers.SerializerMethodField()
    apply_discount = serializers.SerializerMethodField()
    
    class Meta:
        model = DiscountCode
        fields = [
            "id",
            "code",
            "discount_percent",
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
    
    def get_apply_discount(self, obj):
        """
        Returns the discount amount applied to a given order amount.
        Expects 'order_amount' in the serializer context.
        """
        order_amount = self.context.get('order_amount', 0)
        return obj.apply_discount(order_amount)