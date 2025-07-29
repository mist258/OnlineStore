from django.urls import path

from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from .views import ChangePasswordView, LogOutUserView, RequestRecoveryPasswordView

urlpatterns = [
    path("/login",
         TokenObtainPairView.as_view(), name="token_obtain_pair"
         ),  # login user
    path(
        "/refresh", TokenRefreshView.as_view(), name="token_refresh"
    ),  # get new refresh and access tokens
    path(
        "/logout", LogOutUserView.as_view(), name="logout"
    ),  # log out authenticated user
    path(
        "/recovery_request", RequestRecoveryPasswordView.as_view(), name="recovery_request"
    ), # sent request to change password
    path(
        "/recovery_password/<str:token>", ChangePasswordView.as_view(), name="change_password"
    ), # changing password
]
