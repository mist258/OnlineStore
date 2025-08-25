from rest_framework import serializers
from .models import Order, OrderPosition
from apps.users.models import UserModel, UserProfileModel
from apps.products.models import Product, Accessory


class OrderPositionWriteSerializer(serializers.Serializer):
    """
    Write serializer for order positions.
    Only accepts supply_id or accessory_id + quantity from the client.
    """
    supply_id = serializers.IntegerField(required=False)
    accessory_id = serializers.IntegerField(required=False)
    quantity = serializers.IntegerField(min_value=1, default=1)

    def validate(self, attrs):
        supply_id = attrs.get("supply_id")
        accessory_id = attrs.get("accessory_id")

        if not supply_id and not accessory_id:
            raise serializers.ValidationError("Each position must have either 'supply_id' or 'accessory_id'.")
        if supply_id and accessory_id:
            raise serializers.ValidationError("Position cannot have both 'supply_id' and 'accessory_id'.")
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
    customer_data = serializers.DictField(write_only=True)
    billing_details = BillingDetailsSerializer()
    positions = OrderPositionWriteSerializer(many=True, write_only=True)

    class Meta:
        model = Order
        fields = [
            "order_notes",
            "customer_data",
            "billing_details",
            "positions",
        ]

    def create(self, validated_data):
        # Extract nested data
        customer_data = validated_data.pop("customer_data", {})
        billing_data = validated_data.pop("billing_details")
        positions_data = validated_data.pop("positions", [])

        # Create snapshots
        customer_snapshot = UserModel.objects.create_snapshot(customer_data.get("email"))
        billing_snapshot = UserProfileModel.objects.create_snapshot(billing_data)
        

        # Create the order
        order = Order.objects.create(
            customer=customer_snapshot,
            billing_details=billing_snapshot,
            **validated_data
        )

        # Create positions (basic version, may delegate to service)
        for pos in positions_data:
            supply_id = pos.get("supply_id")
            accessory_id = pos.get("accessory_id")
            quantity = pos.get("quantity", 1)

            OrderPosition.objects.create(
                order=order,
                supply_id=supply_id if supply_id else None,
                accessory_id=accessory_id if accessory_id else None,
                quantity=quantity
            )

        return order

    def update(self, instance, validated_data):
        billing_data = validated_data.pop("billing_details", None)
        positions_data = validated_data.pop("positions", None)

        if billing_data:
            for field, value in billing_data.items():
                setattr(instance.billing_details, field, value)
            instance.billing_details.save()

        # Optional: handle positions update here if needed
        return super().update(instance, validated_data)
