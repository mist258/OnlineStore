from django.urls import path

from .views import (
    AddPhotoToProduct,
    CreateProductView,
    DeletePhotoFromProduct,
    DeleteProductView,
    DestroyFlavourProfileView,
    GlobalSearchView,
    ProductByIdView,
    ProductListView,
    UpdateProductView,
)

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
    path(
        "/flavour/<int:pk>", DestroyFlavourProfileView.as_view(), name="update_destroy_flavor"
    ), # destroy flavour by id
    path(
        "/<int:pk>/photo", AddPhotoToProduct.as_view(), name="add_photo"
    ), # add photo to the product
    path(
        "/photo/<int:pk>/deletion", DeletePhotoFromProduct.as_view(), name="delete_photo"
    ), # delete photo from product
    path(
        "/search", GlobalSearchView.as_view(), name="general_search"
    ) # searching for a query for two models Product & Accessory

]