from rest_framework import serializers

from apps.supplies.models import Supply

from core.services.convert_currency_service import CurrencyService


class SupplySerializer(serializers.ModelSerializer):

    converted_price = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = Supply
        fields = ("id",
                  "serving_type",
                  "price",
                  "quantity",
                  "weight",
                  "converted_price",)

        read_only_fields = ("converted_price",)
        extra_kwargs = {
            'id': {'read_only': False, 'required': False}
        }

    def get_converted_price(self, obj):
        request = self.context.get("request")

        currency = "USD"
        if request:
            currency = request.query_params.get("currency", "USD")

        return CurrencyService.convert(
            price_usd=obj.price,
            to_currency=currency,
        )