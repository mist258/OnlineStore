from rest_framework import serializers

from apps.supplies.models import Supply


class SupplySerializer(serializers.ModelSerializer):
    class Meta:
        model = Supply
        fields = ("id",
                  "serving_type",
                  "price",
                  "quantity",
                  "weight",)

        read_only_fields = ("id",)