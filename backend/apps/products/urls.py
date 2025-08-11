from django.urls import path

from .views import ProductByIdView, ProductListView, AccessoryListView, AccessoryByIdView

urlpatterns = [
    path("", ProductListView.as_view(), name="products_list"),
    path("/<int:pk>", ProductByIdView.as_view(), name="products_by_id"),
    path("/accessories", AccessoryListView.as_view(), name="accessories_list"),
    path("/accessories/<int:pk>", AccessoryByIdView.as_view(), name="accessories_by_id"),
]

