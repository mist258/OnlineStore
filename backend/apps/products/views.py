from django.utils.decorators import method_decorator

from rest_framework import generics, status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

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
    queryset = Product.objects.prefetch_related("photos", "supplies", "flavor_profiles").all()
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)


@method_decorator(name='get', decorator=swagger_auto_schema(
    security=[],
    operation_id='get_product_by_id',
    responses={200: ProductSerializer()},
))
class ProductByIdView(generics.RetrieveAPIView):
    """
        get product by id
        (available to anyone)
    """
    queryset = Product.objects.prefetch_related("photos", "supplies", "flavor_profiles").all()
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)


@method_decorator(name='post', decorator=swagger_auto_schema(
    operation_id='add_product',
    responses={200: ProductSerializer()},
))
class CreateProductView(generics.GenericAPIView):
    """
        create a new product dy id
        (available to superuser)
    """
    serializer_class = ProductSerializer

    def post(self, request, *args, **kwargs):
        data = request.data
        serializer = ProductSerializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data,
                        status.HTTP_201_CREATED)


@method_decorator(name='put', decorator=swagger_auto_schema(
    operation_id='full_update_product',
    responses={200: ProductSerializer()},
))
@method_decorator(name='patch', decorator=swagger_auto_schema(
    operation_id='partial_update_product',
    responses={200: ProductSerializer()},
))
class UpdateProductView(generics.GenericAPIView):
    """
        update a product by id
        (available to superuser)
    """
    serializer_class = ProductSerializer
    queryset = Product.objects.all()
    #http_method_names = ("put",)

    def put(self, request, *args, **kwargs):
        data = request.data
        product = self.get_object()
        serializer = ProductSerializer(product, data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data,
                        status.HTTP_200_OK)

    def patch(self, request, *args, **kwargs):
        data = request.data
        product = self.get_object()
        serializer = ProductSerializer(product, data=data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data,
                        status.HTTP_200_OK)


@method_decorator(name='delete', decorator=swagger_auto_schema(
    operation_id='delete_product',
))
class DeleteProductView(generics.GenericAPIView):
    """
        delete a product by id
        (available to superuser)
    """
    serializer_class = ProductSerializer
    queryset = Product.objects.all()

    def delete(self, request, *args, **kwargs):
        product = self.get_object()
        product.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
