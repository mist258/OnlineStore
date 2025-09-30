from django.utils.decorators import method_decorator

from rest_framework import generics, status
from rest_framework.filters import OrderingFilter
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from drf_yasg.utils import swagger_auto_schema

from .models import Accessory, AccessoryPhotosModel
from .serializers import AccessoryPhotoSerializer, AccessorySerializer


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
    queryset = Accessory.objects.prefetch_related('photos_url').all()
    serializer_class = AccessorySerializer
    filter_backends = [OrderingFilter]
    permission_classes = (AllowAny,)


@method_decorator(name='post', decorator=swagger_auto_schema(
    operation_id='add_accessory',
    responses={200: AccessorySerializer()},
))
class AccessoryCreateView(generics.CreateAPIView):
    """
        create a new accessory
        (available to superuser)
    """
    queryset = Accessory.objects.all()
    serializer_class = AccessorySerializer


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
    queryset = Accessory.objects.prefetch_related('photos_url').all()
    serializer_class = AccessorySerializer
    permission_classes = (AllowAny,)


@method_decorator(name='put', decorator=swagger_auto_schema(
    operation_id='add_photo_to_accessory',
))
class AccessoryAddPhotoView(generics.GenericAPIView):
    """
        add a photo to the accessory from local machine
        (available to superuser)
    """
    queryset = Accessory.objects.all()

    def put(self, *args, **kwargs):
        files = self.request.FILES
        accessory = self.get_object()

        for index in files:
            serializer = AccessoryPhotoSerializer(data={"photo": files[index]})
            serializer.is_valid(raise_exception=True)
            serializer.save(accessory=accessory)
        accessory_serializer = AccessorySerializer(accessory)
        return Response(accessory_serializer.data,
                        status=status.HTTP_200_OK)


@method_decorator(name='delete', decorator=swagger_auto_schema(
    operation_id='remove_photo_from_accessory',
))
class AccessoryRemovePhotoView(generics.DestroyAPIView):
    """
        remove a photo from accessory
        (available to superuser)
    """

    queryset = AccessoryPhotosModel.objects.all()

    def delete(self, request, *args, **kwargs):
        photo = self.get_object()

        if photo:
            photo.delete()

            return Response(status=status.HTTP_204_NO_CONTENT)
        return Response(status=status.HTTP_404_NOT_FOUND)

