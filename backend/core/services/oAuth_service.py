from django.conf import settings
from django.contrib.auth import get_user_model

from rest_framework import status
from rest_framework.exceptions import AuthenticationFailed
from rest_framework.generics import get_object_or_404

from core.services.jwt_services import JWTService

from google.auth.transport import requests
from google.oauth2 import id_token

UserModel = get_user_model()

class GoogleOAuthService:

    @staticmethod
    def check_google_auth(google_user):
        try:
            google_request = requests.Request()
            id_info = id_token.verify_oauth2_token(google_user['token'],
                                         google_request,
                                         settings.GOOGLE_OAUTH_CLIENT_ID)
            email = id_info["email"]

            if not email:
                raise AuthenticationFailed(code=status.HTTP_401_UNAUTHORIZED,
                                           detail="Email not found")
        except ValueError:
            raise AuthenticationFailed( code=status.HTTP_401_UNAUTHORIZED ,
                                        detail="Invalid token")

        user = get_object_or_404(UserModel, email=email)
        return JWTService.create_pair_token(user)