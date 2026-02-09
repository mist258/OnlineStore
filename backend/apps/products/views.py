from django.utils.decorators import method_decorator

from rest_framework import generics, status
from rest_framework.filters import OrderingFilter, SearchFilter
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.accessories.models import Accessory
from apps.accessories.serializers import AccessorySerializer
from apps.products.models import Photo, Product, ProductPhotosModel

from core.pagination import PagePagination

from django_filters.rest_framework import DjangoFilterBackend
from drf_yasg.utils import swagger_auto_schema

from .filters import CoffeeProductFilter
from .serializers import ProductPhotoSerializer, ProductSerializer


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
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filterset_class = CoffeeProductFilter
    queryset = Product.objects.prefetch_related("photos_url", "product_photos", "supplies", "flavor_profiles")


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
    queryset = Product.objects.prefetch_related("photos_url", "product_photos", "supplies", "flavor_profiles"
                                                )
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
        flavours = product.flavor_profiles.all()
        for flavour in flavours:
            if flavour.products.count() == 1:
                flavour.delete()
        product.delete()

        return Response(status=status.HTTP_204_NO_CONTENT)


@method_decorator(name="put", decorator=swagger_auto_schema(
    operation_id='add_photo_to_product',
))
class AddPhotoToProduct(generics.GenericAPIView):
    """
        add a photo to the product from local machine
        (available to superuser)
    """
    queryset = Product.objects.all()

    def put(self, *args, **kwargs):
        files = self.request.FILES
        product = self.get_object()

        for index in files:
            serializer = ProductPhotoSerializer(data={"photo": files[index]})
            serializer.is_valid(raise_exception=True)
            serializer.save(product=product)

        product_serializer = ProductSerializer(product)
        return Response(product_serializer.data,
                        status.HTTP_200_OK)


@method_decorator(name="delete", decorator=swagger_auto_schema(
    operation_id='delete_photo_from_product',
))
class DeletePhotoFromProduct(APIView):
    """
        delete a photo from the product by id
        (available to superuser)
    """
    def delete(self, request, pk):
        photo = ProductPhotosModel.objects.filter(pk=pk).first()

        if photo:
            photo.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)

        photo = Photo.objects.filter(pk=pk).first()

        if photo:
            photo.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        return Response({"Details": "Photo not found"},
            status=status.HTTP_404_NOT_FOUND
        )



@method_decorator(name='get', decorator=swagger_auto_schema(
    operation_id='get_accessory_or_product_by_name'
))
class GlobalSearchView(generics.ListAPIView):
    """
        displays the results of a general search by the “name” field
        for "Product" and "Accessory" models
        (available to anyone)
    """
    filter_backends = [SearchFilter]
    pagination_class = PagePagination
    permission_classes = (AllowAny,)

    def get(self, request, *args, **kwargs):
        query = request.query_params.get('search', '')

        products = Product.objects.filter(name__icontains=query)
        prod_data = ProductSerializer(products, many=True)

        accessories = Accessory.objects.filter(name__icontains=query)
        accessory_data = AccessorySerializer(accessories, many=True)

        data = accessory_data.data + prod_data.data

        paginator = self.pagination_class()
        page = paginator.paginate_queryset(data, request, view=self)
        return paginator.get_paginated_response(page)
