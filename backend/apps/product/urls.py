from django.urls import path

from .views import ProductListAPIView
from .views import healthcheck

urlpatterns = [
    path('', healthcheck),
]

urlpatterns = [
    path('api/products/', ProductListAPIView.as_view(), name='product-list'),
]

