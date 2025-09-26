from rest_framework import serializers

from apps.products.models import Product
from apps.supplies.models import Supply


class SupplySerializer(serializers.ModelSerializer):

    converted_price = serializers.SerializerMethodField()

    class Meta:
        model = Supply
        fields = ("id",
                  "serving_type",
                  "price",
                  "quantity",
                  "weight",
                  "converted_price",)

        read_only_fields = ("id",)

    def get_converted_price(self, obj):
        product = Product.objects.all()