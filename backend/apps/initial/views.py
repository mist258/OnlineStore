from rest_framework import generics

from apps.initial.models import InitialTest
from apps.initial.serializers import InitialPhotoSerializer, InitialTestSerializer


class InitialTestView(generics.ListCreateAPIView):
    queryset = InitialTest.objects.all()
    serializer_class = InitialTestSerializer


class InitialAddPhotoView(generics.UpdateAPIView):
    queryset = InitialTest.objects.all()
    serializer_class = InitialPhotoSerializer
    http_method_names = ('put',)
