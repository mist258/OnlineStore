from django.utils.decorators import method_decorator

from rest_framework.permissions import AllowAny

from apps.accessories.models import Accessory
from apps.products.models import Product

from drf_haystack.viewsets import HaystackViewSet
from drf_yasg.utils import swagger_auto_schema

from .serializers import GlobalSearchSerializer


@method_decorator(name='list', decorator=swagger_auto_schema(
    security=[],
    operation_id='search_products_and_accessories'
))
class GlobalItemSearchView(HaystackViewSet):
    """
        Global search view
        (allowed for anyone)
    """
    index_models = [Product, Accessory]
    serializer_class = GlobalSearchSerializer

    def get_permissions(self):
        return [AllowAny()]
