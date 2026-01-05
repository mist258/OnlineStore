from decimal import Decimal

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
            "apply_discount",
            "code"
        ]
        read_only_fields = fields

    def get_is_valid(self, obj):
        """
        Returns True if the discount code is currently valid, else False.
        """
        return obj.is_valid()
    
    def get_apply_discount(self, obj):
        """
        Returns the discount amount (savings) for a given order amount.
        For orders: returns the actual applied discount from context.
        For validation: calculates what discount would be if code is valid.
        Example: if order is $100 and discount is 15%, returns $15.
        """
        # If applied_discount is in context (from order), use that
        applied_discount = self.context.get('applied_discount')
        if applied_discount is not None:
            return applied_discount
        
        # Otherwise calculate based on current validity
        order_amount = self.context.get('order_amount', 0)
        if not obj.is_valid() or order_amount == 0:
            return 0
        
        discount_amount = (obj.discount_percent / Decimal('100.00')) * Decimal(str(order_amount))
        return discount_amount


class DiscountCodeUpdateSerializer(serializers.ModelSerializer):
    description = serializers.CharField(required=False)
    discount_percent = serializers.DecimalField(max_digits=5, decimal_places=2, required=False)
    active = serializers.BooleanField(required=False)
    valid_from = serializers.DateTimeField(required=False)
    valid_to = serializers.DateTimeField(required=False)

    class Meta:
        model = DiscountCode
        fields = [
            "description",
            "discount_percent",
            "active",
            "valid_from",
            "valid_to",
        ]

class AdminDiscountCodesSerializer(serializers.ModelSerializer):

    class Meta:
        model = DiscountCode
        fields = [
            "code",
            "discount_percent",
            "description",
            "active",
            "valid_from",
            "valid_to",
        ]
        extra_kwargs = {
            "code": {"required": True},
            "discount_percent": {"required": True},
            "valid_from": {"required": True},
            "valid_to": {"required": True},
            "description": {"required": False},
            "active": { "required": False},
        }

    def validate(self, attrs):
        """
        Validate that the code does not already exist and dates are valid.
        """
        code = attrs.get("code")

        # Check for duplicate code only when creating or if code is being changed
        if code:
            if self.instance:
                # During update, exclude current instance from duplicate check
                if DiscountCode.objects.filter(code=code).exclude(pk=self.instance.pk).exists():
                    raise serializers.ValidationError(
                        {"code": "This discount code already exists."}
                    )
            else:
                # During create
                if DiscountCode.objects.filter(code=code).exists():
                    raise serializers.ValidationError(
                        {"code": "This discount code already exists."}
                    )

        # Only validate date range if both dates are provided
        valid_from = attrs.get("valid_from")
        valid_to = attrs.get("valid_to")
        
        if valid_from and valid_to and valid_from >= valid_to:
            raise serializers.ValidationError(
                {"valid_to": "valid_to must be later than valid_from."}
            )

        return attrs

    def create(self, validated_data):
        return DiscountCode.objects.create(**validated_data)
