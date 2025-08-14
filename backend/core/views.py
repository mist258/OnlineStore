from rest_framework.generics import GenericAPIView
from rest_framework.mixins import DestroyModelMixin, UpdateModelMixin


class UpdateDestroyAPIView(UpdateModelMixin,
                           DestroyModelMixin,
                           GenericAPIView):
    pass