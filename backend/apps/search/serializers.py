from drf_haystack.serializers import HaystackSerializer

from .search_indexes import AccessorySearchIndex, ProductSearchIndex


class GlobalSearchSerializer(HaystackSerializer):

    class Meta:
        index_classes = [ProductSearchIndex, AccessorySearchIndex]
        fields = ("search_by_name",
                  "type")
