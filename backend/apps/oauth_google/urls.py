from django.urls import path

from .views import OauthGoogleView

urlpatterns = [
    path("", OauthGoogleView.as_view(), name="oauth_google"),
]