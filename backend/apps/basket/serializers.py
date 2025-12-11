from rest_framework import serializers
from apps.basket.models import Basket, BasketItem, DiscountCode
from apps.products.models import Product
from apps.accessories.models import Accessory
from apps.supplies.models import Supply
from apps.basket.services.basket_service import add_item_to_basket, BasketItemCreationError

class BasketItemSerializer(serializers.ModelSerializer):
    product_name = serializers.CharField(source="product.name", read_only=True)
    accessory_name = serializers.CharField(source="accessory.name", read_only=True)

    total_price = serializers.DecimalField(
        max_digits=10, decimal_places=2, read_only=True
    )

    # Input fields → converted to instances automatically
    product_id = serializers.PrimaryKeyRelatedField(
        source="product",
        queryset=Product.objects.all(),
        required=False,
        allow_null=True
    )

    supply_id = serializers.PrimaryKeyRelatedField(
        source="supply",
        queryset=Supply.objects.all(),
        required=False,
        allow_null=True
    )

    accessory_id = serializers.PrimaryKeyRelatedField(
        source="accessory",
        queryset=Accessory.objects.all(),
        required=False,
        allow_null=True
    )

    basket_id = serializers.IntegerField()

    class Meta:
        model = BasketItem
        fields = [
            "id",
            "product_id",
            "accessory_id",
            "product_name",
            "supply_id",
            "accessory_name",
            "quantity",
            "total_price",
            "basket_id",
        ]

    def validate(self, attrs):
        """Main business rule:
        Either:
            accessory_id
        OR:
            product_id + supply_id
        """

        user = self.context['request'].user

        product = attrs.get("product")
        supply = attrs.get("supply")
        accessory = attrs.get("accessory")
        quantity = attrs.get("quantity") or 1
        basket_id = attrs.get("basket_id")

        # 1️⃣ Validate combination rules
        if not accessory and not supply:
            raise serializers.ValidationError({
                "error": "supply_id must be provided when product_id is used."
            })

        if not accessory and not product:
            raise serializers.ValidationError({
                "error": "product_id must be provided when supply_id is used."
            })

        if not accessory and not (product and supply):
            raise serializers.ValidationError({
                "error": "Provide either accessory_id OR product_id + supply_id."
            })

        # 2️⃣ Validate basket ownership
        try:
            basket = Basket.objects.get(id=basket_id, user=user)
        except Basket.DoesNotExist:
            raise serializers.ValidationError({
                "basket_id": "Basket not found or does not belong to user."
            })

        # 3️⃣ Validate supply belongs to product
        if supply and supply.product != product:
            raise serializers.ValidationError({
                "supply_id": "This supply does not belong to provided product."
            })

        # 4️⃣ Validate stock availability
        if supply and supply.quantity < quantity:
            raise serializers.ValidationError({
                "error": f"Requested quantity {quantity} unavailable. "
                         f"Supply has {supply.quantity} units."
            })

        if accessory and accessory.quantity < quantity:
            raise serializers.ValidationError({
                "error": f"Requested quantity {quantity} unavailable. "
                         f"Accessory has {accessory.quantity} units."
            })

        # Store parsed instances for create()
        attrs["basket"] = basket
        return attrs

    def create(self, validated_data):
        """Use your service layer to create the basket item."""
        basket = validated_data["basket"]
        accessory = validated_data.get("accessory")
        product = validated_data.get("product")
        supply = validated_data.get("supply")
        quantity = validated_data["quantity"]

        try:
            return add_item_to_basket(
                basket=basket,
                accessory=accessory,
                product=product,
                supply=supply,
                quantity=quantity
            )
        except BasketItemCreationError as e:
            raise serializers.ValidationError({"error": str(e)})



class BasketSerializer(serializers.ModelSerializer):
    items = BasketItemSerializer(many=True, read_only=True)
    total_price = serializers.DecimalField(
        max_digits=10, decimal_places=2, read_only=True
    )
    discount_code = serializers.CharField(source="discount_code.code", read_only=True)

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
