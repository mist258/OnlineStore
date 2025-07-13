from typing import Type

from django.contrib.auth import get_user_model
from django.contrib.auth.base_user import AbstractBaseUser
from django.utils.decorators import method_decorator

from rest_framework import generics, status
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.auth.serializers import EmailSerializer, PasswordSerializer

from core.services.email_service import EmailService
from core.services.jwt_services import JWTService, RecoveryToken

from drf_yasg.utils import swagger_auto_schema
from rest_framework_simplejwt.tokens import RefreshToken

UserModel: Type[AbstractBaseUser] = get_user_model()

@method_decorator(
    name="post", decorator=swagger_auto_schema(operation_id="log_out_user")
)
class LogOutUserView(APIView):
    """
    Log out user
    """

    permission_classes = (IsAuthenticated,)

    def post(self, request):
        try:
            refresh = request.data["refresh"]
            token = RefreshToken(refresh)
            token.blacklist()
            return Response(
                {"Details": "User is logged out successfully"},
                status.HTTP_205_RESET_CONTENT,
            )
        except Exception as e:
            return Response({"Details": str(e)}, status.HTTP_400_BAD_REQUEST)


@method_decorator(
    name="post", decorator=swagger_auto_schema(operation_id="request_recovery_password")
)
class RequestRecoveryPasswordView(generics.GenericAPIView):
    """
     sending request recovery password
     (allow any users)
    """
    serializer_class = EmailSerializer
    permission_classes = (AllowAny,)

    def post(self, request, *args, **kwargs):
        data = request.data
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        user = get_object_or_404(UserModel, **serializer.data)
        EmailService.send_recovery_email(user)
        return Response({"Details": "Email successfully sent to user"},
                        status.HTTP_200_OK)


@method_decorator(
    name="post", decorator=swagger_auto_schema(operation_id="change_password")
)
class ChangePasswordView(generics.GenericAPIView):
    """
     change password
     (allow any users)
    """
    serializer_class = PasswordSerializer
    permission_classes = (AllowAny,)

    def post(self, request, *args, **kwargs):
        data = request.data
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        token = kwargs["token"]
        user = JWTService.validate_token(token, RecoveryToken)
        user.set_password(serializer.data["password"])
        user.save()
        return Response({"Details": "Password successfully changed"},
                        status.HTTP_200_OK)