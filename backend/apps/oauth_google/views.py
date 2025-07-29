from django.utils.decorators import method_decorator

from rest_framework import generics, status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from core.services.oAuth_service import GoogleOAuthService

from drf_yasg.utils import swagger_auto_schema

from .serializers import GoogleOAuthSerializer


@method_decorator(name='post',
                  decorator=swagger_auto_schema(
                      security=[],
                      operation_id='login_via_google',
                  ))
class OauthGoogleView(generics.GenericAPIView):
    """
        auth via Google
        (allow any users)
    """

    serializer_class = GoogleOAuthSerializer
    permission_classes = (AllowAny,)

    def post(self, request, *args, **kwargs):
        data = request.data
        google_data = GoogleOAuthSerializer(data=data)
        google_data.is_valid(raise_exception=True)
        token = GoogleOAuthService.check_google_auth(google_data.validated_data)
        refresh = token['refresh']
        access = token['access']
        return Response({
            'access': access,
            'refresh': refresh,
        }, status=status.HTTP_200_OK)

