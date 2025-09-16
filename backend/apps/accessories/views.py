from django.utils.decorators import method_decorator

from rest_framework import generics
from rest_framework.filters import OrderingFilter
from rest_framework.permissions import AllowAny

from drf_yasg.utils import swagger_auto_schema

from .models import Accessory
from .serializers import AccessorySerializer


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

