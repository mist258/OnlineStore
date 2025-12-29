from django.contrib.auth import get_user_model

from rest_framework import generics

UserModel = get_user_model()


class SubscribeUserForUpdateView(generics.GenericAPIView):
    pass


class UnsubscribeUserFromUpdateView(generics.GenericAPIView):
    pass
