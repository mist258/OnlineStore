from django.utils.decorators import method_decorator

from rest_framework import generics, status
from rest_framework.filters import OrderingFilter
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from apps.products.models import Accessory, FlavorProfile, PhotosModel, Product

from core.views import UpdateDestroyAPIView

from django_filters.rest_framework import DjangoFilterBackend
from drf_yasg.utils import swagger_auto_schema

from .filters import CoffeeProductFilter
from .serializers import AccessorySerializer, FlavourProfileSerializer, ProductPhotoSerializer, ProductSerializer


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
    queryset = Product.objects.prefetch_related("photos_url", "product_photos", "supplies", "flavor_profiles").all()
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filterset_class = CoffeeProductFilter


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
    queryset = Product.objects.prefetch_related("photos_url", "product_photos", "supplies", "flavor_profiles").all()
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
        product.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


@method_decorator(name="get", decorator=swagger_auto_schema(
    operation_id='get_all_flavours',
    responses={200: ProductSerializer(many=True)},
))
@method_decorator(name="post", decorator=swagger_auto_schema(
    operation_id='add_flavours',
    responses={200: FlavourProfileSerializer()},
))
class ListCreateFlavourProfileView(generics.ListCreateAPIView):
    """
        get: show the entire list of flavour
        post: create a new flavour
        (available to superuser)
    """

    queryset = FlavorProfile.objects.all()
    serializer_class = FlavourProfileSerializer


@method_decorator(name="put", decorator=swagger_auto_schema(
    operation_id='update_flavour_by_id',
    responses={200: FlavourProfileSerializer()},
))
@method_decorator(name="delete", decorator=swagger_auto_schema(
    operation_id='delete_flavour_by_id'
))
class UpdateDestroyFlavourProfileView(UpdateDestroyAPIView):
    """
        delete: delete the flavour by id
        put: update the flavour by id
        (available to superuser)
    """
    queryset = FlavorProfile.objects.all()
    serializer_class = FlavourProfileSerializer
    http_method_names = ("put", "delete")

    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)


@method_decorator(name="put", decorator=swagger_auto_schema(
    operation_id='add_photo_to_product',
    responses={200: ProductSerializer()},
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
class DeletePhotoFromProduct(generics.GenericAPIView):
    """
        delete a photo from the product by id
        (available to superuser)
    """
    queryset = PhotosModel.objects.all()

    def delete(self, request, *args, **kwargs):
        photo = self.get_object()

        if photo:
            photo.delete()

            return Response(status=status.HTTP_204_NO_CONTENT)
        return Response(status=status.HTTP_404_NOT_FOUND)


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