from rest_framework.permissions import AllowAny

from apps.accessories.models import Accessory
from apps.products.models import Product

from drf_haystack.viewsets import HaystackViewSet

from .serializers import GlobalSearchSerializer


class GlobalItemSearchView(HaystackViewSet):
    """
        Global search view
        (allowed for anyone)
    """
    index_models = [Product, Accessory]
    serializer_class = GlobalSearchSerializer

    def get_permissions(self):
        return [AllowAny()]
