from django.urls import path

from apps.product.views import ProductListAPIView, healthcheck

urlpatterns = [
    path('', healthcheck),
]

urlpatterns = [
    path('api/products/', ProductListAPIView.as_view(), name='product-list'),
]

