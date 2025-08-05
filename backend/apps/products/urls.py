from django.urls import path

from .views import CreateProductView, ProductByIdView, ProductListView

urlpatterns = [
    path("", ProductListView.as_view(), name="products_list"),
    path("/<int:pk>", ProductByIdView.as_view(), name="products_by_id"),
    path("/product", CreateProductView.as_view(), name="create_product"),
]

