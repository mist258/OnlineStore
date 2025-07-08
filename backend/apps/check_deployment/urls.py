from django.urls import path

from .views import CheckDeploymentView

urlpatterns = [
    path("", CheckDeploymentView.as_view()),
]
