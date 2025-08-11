from django.utils.decorators import method_decorator

from rest_framework import generics
from rest_framework.permissions import AllowAny

from apps.products.models import Product, Accessory

from drf_yasg.utils import swagger_auto_schema

from .serializers import ProductSerializer, AccessorySerializer


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


@method_decorator(name='get', decorator=swagger_auto_schema(
    security=[],
    operation_id='get_product_by_id',
    responses={200: ProductSerializer(many=True)},
))
class ProductByIdView(generics.RetrieveAPIView):
    """
        get product by id
        (available to anyone)
    """
    queryset = Product.objects.prefetch_related('photos', 'supplies').all()
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)


@method_decorator(name='get', decorator=swagger_auto_schema(
    security=[],
    operation_id='get_all_accessories',
    responses={200: AccessorySerializer(many=True)},
))
class AccessoryListView(generics.ListAPIView):
    """
        shows the entire list of accessories
        (available to anyone)
    """
    queryset = Accessory.objects.prefetch_related('photos').all()
    serializer_class = AccessorySerializer
    permission_classes = (AllowAny,)
    
    
@method_decorator(name='get', decorator=swagger_auto_schema(
    security=[],
    operation_id='get_accessory_by_id',
    responses={200: AccessorySerializer(many=True)},
))
class AccessoryByIdView(generics.RetrieveAPIView):
    """
        get accessory by id
        (available to anyone)
    """
    queryset = Accessory.objects.prefetch_related('photos').all()
    serializer_class = AccessorySerializer
    permission_classes = (AllowAny,)