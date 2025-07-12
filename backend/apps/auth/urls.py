from django.urls import path

from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from .views import LogOutUserView

urlpatterns = [
    path("", TokenObtainPairView.as_view(), name="token_obtain_pair"),  # login user
    path(
        "/refresh", TokenRefreshView.as_view(), name="token_refresh"
    ),  # get new refresh and access tokens
    path(
        "/logout", LogOutUserView.as_view(), name="logout"
    ),  # log out authenticated user
]
