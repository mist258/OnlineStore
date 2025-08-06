from django.urls import path

from .views import CreateProductView, DeleteProductView, ProductByIdView, ProductListView, UpdateProductView

urlpatterns = [
    path(
        "", ProductListView.as_view(), name="products_list"
    ), # show all products
    path(
        "/<int:pk>", ProductByIdView.as_view(), name="products_by_id"
    ), # show product by id
    path(
        "/product", CreateProductView.as_view(), name="create_product"
    ), # add product
    path(
        "/product/<int:pk>", UpdateProductView.as_view(), name="update_product"
    ), # full/partial update product by id
    path(
        "/<int:pk>/deletion", DeleteProductView.as_view(), name="delete_product"
    ), # delete product by id

]

