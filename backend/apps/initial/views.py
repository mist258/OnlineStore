from rest_framework import generics

from apps.initial.models import InitialTest
from apps.initial.serializers import InitialTestSerializer


class InitialTestView(generics.ListCreateAPIView):
    queryset = InitialTest.objects.all()
    serializer_class = InitialTestSerializer


