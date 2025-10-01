from django.db import transaction

from rest_framework import serializers

from apps.basket.models import Basket
from apps.orders.models import Order, OrderPosition
from apps.products.models import Accessory, Product
from apps.users.models import UserModel, UserProfileModel


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


class OrderWriteSerializer(serializers.ModelSerializer):
    """
    Serializer for creating/updating orders.
    Accepts billing details + positions.
    """
    customer_data = serializers.DictField(write_only=True, required=False)
    order_notes = serializers.CharField(required=False, allow_blank=True)
    billing_details = BillingDetailsSerializer(required=False)
    positions = OrderPositionWriteSerializer(many=True, write_only=True, required=False)
    basket_id = serializers.IntegerField(required=False, write_only=True)
    status = serializers.ChoiceField(choices=Order.STATUS_CHOICES, required=False)

    class Meta:
        model = Order
        fields = [
            "order_notes",
            "customer_data",
            "billing_details",
            "positions",
            "basket_id",
            'status',
        ]

    def create(self, validated_data):
        try:
            with transaction.atomic():
                customer_data = validated_data.pop("customer_data", {})
                billing_data = validated_data.pop("billing_details")
                positions_data = validated_data.pop("positions", [])
                basket_id = validated_data.pop("basket_id")

                # Create snapshots
                customer_snapshot = UserModel.objects.create_snapshot(
                    customer_data.get("email")
                )
                billing_snapshot = UserProfileModel.objects.create_snapshot(
                    billing_data
                )

                # Create the order
                order = Order.objects.create(
                    customer=customer_snapshot,
                    billing_details=billing_snapshot,
                    **validated_data
                )

                # Create positions from basket
                basket = Basket.objects.get(id=basket_id)
                for basket_item in basket.items.all():
                    OrderPosition.objects.create(
                        order=order,
                        product=basket_item.product,
                        supply=basket_item.supply,
                        quantity=basket_item.quantity
                    )

                return order
        except Exception as e:
            raise serializers.ValidationError(f"Failed to create order: {str(e)}")

    def update(self, instance, validated_data):

        billing_data = validated_data.pop("billing_details", None)
        positions_data = validated_data.pop("positions", None)

        if billing_data:
            print(">>> Updating billing details:", billing_data)
            for field, value in billing_data.items():
                setattr(instance.billing_details, field, value)
            instance.billing_details.save()

        status_val = validated_data.pop("status", None)
        if status_val is not None:

            instance.status = status_val

        for field, value in validated_data.items():
            setattr(instance, field, value)

        instance.save()
        return instance


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
            "quantity",
            "product",
            "accessory",
        ]
        read_only_fields = fields

    def get_product(self, obj):
        if obj.product:
            return {
                "id": obj.product.id,
                "name": obj.product.name,
                "quantity": obj.quantity,
                "total_price": obj.total_price,
            }
        return None

    def get_accessory(self, obj):
        if obj.accessory:
            return {
                "id": obj.accessory.id,
                "name": obj.accessory.name,
                "price": obj.accessory.price,
                "quantity": obj.quantity,
                "total_price": obj.total_price,
            }
        return None


class OrderReadSerializer(serializers.ModelSerializer):
    """
    Read-only serializer for orders.
    Includes nested billing details and positions.
    """
    billing_details = BillingDetailsSerializer(read_only=True)
    positions = OrderPositionReadSerializer(read_only=True, many=True)
    
    class Meta:
        model = Order
        fields = [
            "id",
            "order_notes",
            "status",
            "customer",
            "billing_details",
            "positions",
        ]
        read_only_fields = fields

    def get_positions(self, obj):
        positions = OrderPosition.objects.filter(order=obj)
        return OrderPositionReadSerializer(positions, many=True).data