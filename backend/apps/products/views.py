from django.utils.decorators import method_decorator

from rest_framework import generics
from rest_framework.permissions import AllowAny

from apps.products.models import Product

from drf_yasg.utils import swagger_auto_schema

from .serializers import ProductSerializer


@method_decorator(name='get', decorator=swagger_auto_schema(
    security=[],
    operation_id='get_all_products',
    responses={200: ProductSerializer(many=True)},
))
class ProductListView(generics.ListAPIView):
    """
        shows the entire list of products
        (available to anyone)
    """
    queryset = Product.objects.prefetch_related('photos', 'supplies').all()
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)

class ProductByIdView(generics.RetrieveAPIView):
    queryset = Product.objects.prefetch_related('photos', 'supplies').all()
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)
