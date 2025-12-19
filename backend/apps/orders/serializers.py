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


from django.db import transaction
from rest_framework import serializers


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
    
    
class OrderWriteSerializer(serializers.ModelSerializer):
    """
    Serializer for creating/updating orders.
    Accepts billing details + positions.
    """

    billing_details = BillingDetailsSerializer(write_only=True)
    order_notes = serializers.CharField(required=False, allow_blank=True)
    positions = OrderPositionReadSerializer(many=True, read_only=True)
    basket_id = serializers.IntegerField(required=True, write_only=True)
    status = serializers.ChoiceField(
        choices=Order.STATUS_CHOICES,
        required=False
    )

    class Meta:
        model = Order
        fields = [
            "id",
            "order_notes",
            "basket_id",
            "status",
            "billing_details",
            "positions"
        ]

    def create(self, validated_data):
        try:
            with transaction.atomic():
                customer = self.context['request'].user
                billing_data = validated_data.pop("billing_details")
                basket_id = validated_data.pop("basket_id")

                # Map billing_details → Order fields
                order = Order.objects.create(
                    customer=customer,

                    billing_first_name=billing_data["first_name"],
                    billing_last_name=billing_data["last_name"],
                    billing_company_name=billing_data.get("company_name"),

                    billing_country=billing_data["country"],
                    billing_state=billing_data.get("state"),
                    billing_region=billing_data.get("region"),

                    billing_street_name=billing_data.get("street_name"),
                    billing_apartment_number=billing_data.get("apartment_number"),
                    billing_zip_code=billing_data.get("zip_code"),

                    billing_phone_number=billing_data["phone_number"],

                    **validated_data
                )

                # Create positions from basket
                basket = Basket.objects.filter(id=basket_id).first()
                if not basket:
                    raise serializers.ValidationError(
                        f"Failed to find a basket by id={basket_id}"
                    )

                if not basket.items.exists():
                    raise serializers.ValidationError(
                        "Failed to create an order from basket — it's empty."
                    )

                for basket_item in basket.items.all():
                    # check quantity before creating order position
                    if basket_item.accessory and basket_item.quantity > basket_item.accessory.quantity:
                        raise serializers.ValidationError(
                            f"The product={basket_item.accessory.name} has only {basket_item.accessory.quantity} from required {basket_item.quantity}"
                        )
                        
                    if basket_item.product and basket_item.quantity > basket_item.supply.quantity:
                        raise serializers.ValidationError(
                            f"The product={basket_item.product.name} has only {basket_item.supply.quantity} from required {basket_item.quantity}"
                        )
                        
                    OrderPosition.objects.create(
                        order=order,
                        product=basket_item.product,
                        quantity=basket_item.quantity
                    )

                return order

        except Exception as e:
            raise serializers.ValidationError(
                f"Failed to create order: {str(e)}"
            )


    def update(self, instance, validated_data):

        billing_data = validated_data.pop("billing_details", None)

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