from django.urls import path

from .views import CreateUserView, GetMyInfoView

urlpatterns = [
    path('', CreateUserView.as_view(), name='register_user'),
    path('/info', GetMyInfoView.as_view(), name='get_own_info'),
]
