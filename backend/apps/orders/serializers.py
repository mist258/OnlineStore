from django.core.exceptions import ValidationError as DjangoValidationError

from rest_framework import serializers

from apps.basket.models import Basket
from apps.discount_codes.models import DiscountCode
from apps.discount_codes.serializers import DiscountCodesSerializer
from apps.orders.models import Order, OrderPosition
from apps.orders.services.order_service import create_order_from_basket
from apps.users.models import UserProfileModel


class OrderPositionWriteSerializer(serializers.Serializer):
    """
    Write serializer for order positions.
    """
    supply_id = serializers.IntegerField(required=False)
    accessory_id = serializers.IntegerField(required=False)
    product_id = serializers.IntegerField(required=False)
    quantity = serializers.IntegerField(min_value=1, default=1)

    def validate(self, attrs):
        supply_id = attrs.get("supply_id")
        accessory_id = attrs.get("accessory_id")
        product_id = attrs.get("product_id")

        if not any([supply_id, accessory_id, product_id]):
            raise serializers.ValidationError(
                "Each position must have either 'supply_id', 'product_id' or 'accessory_id'."
            )
        return attrs


class BillingDetailsSerializer(serializers.ModelSerializer):
    """
    Serializer for snapshot of billing details (UserProfileModel).
    """
    class Meta:
        model = UserProfileModel
        exclude = ["user"]  # snapshot usually doesn't link back to User


class OrderPositionReadSerializer(serializers.ModelSerializer):
    """
    Read-only serializer for order positions.
    Includes nested product or accessory details.
    """
    product = serializers.SerializerMethodField()
    accessory = serializers.SerializerMethodField()
    
    class Meta:
        model = OrderPosition
        fields = [
            "id",
            "product",
            "accessory",
        ]
        read_only_fields = fields

    def get_product(self, obj):
        if obj.product:
            return {
                "id": obj.product.id,
                "name": obj.product.name,
                "price": obj.price,
                "quantity": obj.quantity,
                "images": list(obj.product.photos_url.values("url")),
                "total_price": obj.evaluate_total_price,
            }
        return None

    def get_accessory(self, obj):
        if obj.accessory:
            return {
                "id": obj.accessory.id,
                "name": obj.accessory.name,
                "price": obj.price,
                "quantity": obj.quantity,
                "images": list(obj.accessory.photos_url.values("url")),
                "total_price": obj.evaluate_total_price,
            }
        return None
    
    
class OrderWriteSerializer(serializers.ModelSerializer):
    """
    Serializer for creating/updating orders.
    Accepts billing details + positions.
    """

    billing_details = BillingDetailsSerializer(write_only=True, required=False)
    order_notes = serializers.CharField(required=False, allow_blank=True)
    positions = OrderPositionReadSerializer(many=True, read_only=True)
    status = serializers.ChoiceField(
        choices=Order.STATUS_CHOICES,
        required=False
    )
    created_at = serializers.DateTimeField(read_only=True)
    order_amount = serializers.SerializerMethodField(read_only=True)
    discount_code = serializers.CharField(required=False)

    class Meta:
        model = Order
        fields = [
            "id",
            "order_notes",
            "status",
            "billing_details",
            "positions",
            "ttn",
            "discount_code",
            "created_at",
            "order_amount",
        ]

    def validate(self, attrs):
        discount_code = None
        discount_code_value = attrs.get("discount_code", None)
        if discount_code_value is not None:
            try:
                discount_code = DiscountCode.objects.get(code=discount_code_value)
                # Validate that discount code is valid (active and within date range)
                if not discount_code.is_valid():
                    raise serializers.ValidationError(
                        f"Discount code '{discount_code_value}' is not valid. "
                        "It may be inactive or outside its valid date range."
                    )
            except DiscountCode.DoesNotExist:
                raise serializers.ValidationError(
                    f"Discount code '{discount_code_value}' does not exist."
                )
        
        if self.instance:
            return attrs

        user = self.context["request"].user
        basket = Basket.objects.filter(user=user).first()

        if not basket:
            raise serializers.ValidationError("Basket does not exist")

        if not basket.items.exists():
            raise serializers.ValidationError("Basket is empty")

        self._basket = basket
        self._discount_code = discount_code
        return attrs

    def create(self, validated_data):
        user = self.context["request"].user
        billing_data = validated_data.pop("billing_details", None)

        try:
            return create_order_from_basket(
                customer=user,
                basket=self._basket,
                billing_data=billing_data,
                discount_code=self._discount_code,
                notes=validated_data.get("order_notes"),
            )
        except DjangoValidationError as e:
            # Convert Django ValidationError to DRF ValidationError for proper 400 response
            raise serializers.ValidationError(str(e))

    def update(self, instance, validated_data):
        billing_data = validated_data.pop("billing_details", None)

        if billing_data:
            for field, value in billing_data.items():
                setattr(instance, field, value)

        for field, value in validated_data.items():
            setattr(instance, field, value)

        instance.save()
        return instance
    
    def get_order_amount(self, obj):
        return obj.get_order_amount()


class OrderReadSerializer(serializers.ModelSerializer):
    """
    Read-only serializer for orders.
    Includes nested billing details and positions.
    """
    positions = OrderPositionReadSerializer(read_only=True, many=True)
    order_amount = serializers.SerializerMethodField()
    discount_code = serializers.SerializerMethodField()
    
    class Meta:
        model = Order
        fields = [
            "id",
            "order_notes",
            "status",
            "customer",
            "positions",
            "ttn",
            "discount_code",
            "created_at",
            "updated_at",
            "first_name",
            "last_name",
            "company_name",
            "country",
            "state",
            "region",
            "street_name",
            "apartment_number",
            "zip_code",
            "phone_number",
            "order_amount",
        ]
        read_only_fields = [
            "id",
            "order_notes",
            "status",
            "customer",
            "positions",
            "ttn",
            "discount_code",
            "created_at",
            "updated_at",
            "first_name",
            "last_name",
            "company_name",
            "country",
            "state",
            "region",
            "street_name",
            "apartment_number",
            "zip_code",
            "phone_number",
            "order_amount",
        ]

    def get_positions(self, obj):
        positions = OrderPosition.objects.filter(order=obj)
        return OrderPositionReadSerializer(positions, many=True).data
    
    def get_order_amount(self, obj):
        return obj.get_order_amount()
    
    def get_discount_code(self, obj):
        """
        Serialize discount code with actual applied discount amount.
        For orders, we show the historical discount that was applied,
        not what it would be if applied now.
        """
        if obj.discount_code:
            # Calculate order amount before discount
            total_before_discount = sum(
                position.evaluate_total_price for position in obj.positions.all()
            )
            # Calculate the actual discount that was applied
            actual_discount_amount = total_before_discount - obj.get_order_amount()
            
            return DiscountCodesSerializer(
                obj.discount_code, 
                context={
                    'order_amount': total_before_discount,
                    'applied_discount': actual_discount_amount  # Historical discount
                }
            ).data
        return None