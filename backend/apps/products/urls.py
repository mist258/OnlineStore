from django.urls import path

from .views import (
    AccessoryByIdView,
    AccessoryCreateView,
    AccessoryListView,
    AddPhotoToProduct,
    CreateProductView,
    DeletePhotoFromProduct,
    DeleteProductView,
    GlobalSearchView,
    ListCreateFlavourProfileView,
    ProductByIdView,
    ProductListView,
    UpdateDestroyFlavourProfileView,
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
        "/flavour", ListCreateFlavourProfileView.as_view(), name="list_create_flavor"
    ), # list all & create new flavour
    path(
        "/flavour/<int:pk>", UpdateDestroyFlavourProfileView.as_view(), name="update_destroy_flavor"
    ), # update & destroy flavour by id
    path(
        "/<int:pk>/photo", AddPhotoToProduct.as_view(), name="add_photo"
    ), # add photo to the product
    path(
        "/photo/<int:pk>/deletion", DeletePhotoFromProduct.as_view(), name="delete_photo"
    ), # delete photo from product
    path(
        "/accessories", AccessoryListView.as_view(), name="accessories_list"
    ), # display a list of all accessories
    path(
        "/accessories/<int:pk>", AccessoryByIdView.as_view(), name="accessories_by_id"
    ), # display a specific accessory by its id
    path(
        "/new_accessory", AccessoryCreateView.as_view(), name="new_accessory"
    ), # add new accessory
    path(
        "/search", GlobalSearchView.as_view(), name="general_search"
    ) # searching for a query for two models Product & Accessory

]