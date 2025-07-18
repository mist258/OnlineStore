from django.utils.decorators import method_decorator

from rest_framework import generics
from rest_framework.permissions import AllowAny

from drf_yasg.utils import swagger_auto_schema

from .serializers import OauthGoogleSerializer


@method_decorator(name='post',
                  decorator=swagger_auto_schema(
                      security=[],
                      operation_id='login_via_google',
                  ))
class OauthGoogleView(generics.GenericAPIView): # todo
    """
        auth via Google
        (allow any users)
    """

    serializer_class = OauthGoogleSerializer
    permission_classes = (AllowAny,)

    def post(self, request, *args, **kwargs):
        data = request.data
        google_data = OauthGoogleSerializer(data=data)
        google_data.is_valid(raise_exception=True)

