from django.utils.decorators import method_decorator

from rest_framework import generics, status
from rest_framework.response import Response

from apps.products.serializers import ProductSerializer

from drf_yasg.utils import swagger_auto_schema

from ..products.models import Product
from .models import Supply
from .serializers import SupplySerializer


@method_decorator(name='post', decorator=swagger_auto_schema(
    operation_id="create_supply_to_product",
    responses={200: ProductSerializer()},
))
class AddSupplyToProduct(generics.GenericAPIView):
    """"
        add a supplies to the product
        (available to superuser)
    """
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    def post(self, request, *args, **kwargs):
        product = self.get_object()
        data = request.data
        serializer = SupplySerializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save(product=product)
        product_serializer = ProductSerializer(product)
        return Response(product_serializer.data,
                        status=status.HTTP_201_CREATED)


@method_decorator(name='delete', decorator=swagger_auto_schema(
    operation_id="delete_supply_from_product",
))
@method_decorator(name='put', decorator=swagger_auto_schema(
    operation_id="update_supply_from_product",
))
@method_decorator(name='patch', decorator=swagger_auto_schema(
    operation_id="partial_update_supply_from_product",
))
class UpdateDestroySupplyFromProduct(generics.RetrieveUpdateDestroyAPIView):
    """
        update a supplies from the product
        (available to superuser)
    """
    queryset = Supply.objects.all()
    serializer_class = SupplySerializer
    allowed_methods = ("put", "patch", "delete")




