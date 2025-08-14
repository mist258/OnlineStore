from django.urls import path

from .views import AddSupplyToProduct, UpdateDestroySupplyFromProduct

urlpatterns = [
    path(
        "/products/<int:pk>", AddSupplyToProduct.as_view(), name="add_supply_to_product"
    ), # add supplies to product by id
    path(
        "/<int:pk>", UpdateDestroySupplyFromProduct.as_view(), name="update_supply_from_product"
    ), # update & delete & partial update supplies from product by id

]
