from rest_framework import serializers

from apps.accessories.serializers import AccessorySerializer
from apps.products.serializers import ProductSerializer

from drf_haystack.serializers import HaystackSerializer

from .search_indexes import AccessorySearchIndex, ProductSearchIndex


class GlobalSearchSerializer(HaystackSerializer):
    object = serializers.SerializerMethodField()

    class Meta:
        index_classes = [ProductSearchIndex, AccessorySearchIndex]
        index_objects=True
        fields = ("text",
                  "type",
                  "object",)

    def get_object(self, obj):
        if obj.type == "accessory":
            return AccessorySerializer(obj.object).data
        if obj.type == "product":
            return ProductSerializer(obj.object).data
        return None

