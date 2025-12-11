from rest_framework import serializers

from apps.basket.models import DiscountCode


class DiscountCodesSerializer(serializers.ModelSerializer):
    is_valid = serializers.SerializerMethodField()
    apply_discount = serializers.SerializerMethodField()
    code = serializers.CharField()
    
    class Meta:
        model = DiscountCode
        fields = [
            "id",
            "discount_percent",
            "valid_from",
            "valid_to",
            "is_valid",
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


class AdminDiscountCodesSerializer(serializers.ModelSerializer):

    class Meta:
        model = DiscountCode
        fields = [
            "code",
            "discount_percent",
            "valid_from",
            "valid_to",
        ]
        extra_kwargs = {
            "code": {"required": True},
            "discount_percent": {"required": True},
            "valid_from": {"required": True},
            "valid_to": {"required": True},
        }

    def validate(self, attrs):
        """
        Validate that the code does not already exist and dates are valid.
        """
        code = attrs.get("code")

        if DiscountCode.objects.filter(code=code).exists():
            raise serializers.ValidationError(
                {"code": "This discount code already exists."}
            )

        if attrs["valid_from"] >= attrs["valid_to"]:
            raise serializers.ValidationError(
                {"valid_to": "valid_to must be later than valid_from."}
            )

        return attrs

    def create(self, validated_data):
        return DiscountCode.objects.create(**validated_data)
