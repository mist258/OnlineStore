from django.urls import path

from .views import (
    AccessoryAddPhotoView,
    AccessoryByIdView,
    AccessoryCreateView,
    AccessoryListView,
    AccessoryRemovePhotoView,
    AccessoryUpdateView,
)

urlpatterns = [
    path(
        '', AccessoryListView.as_view(), name='list_accessories'
    ), # display a list of all accessories
    path(
        "/<int:pk>", AccessoryByIdView.as_view(), name='accessory_by_id'
    ), # display a specific accessory by its ID
    path(
        "/new_accessory", AccessoryCreateView.as_view(), name='add_accessory'
    ), # add new accessory
    path(
        "/<int:pk>/photo", AccessoryAddPhotoView.as_view(), name='add_photo'
    ), # allow add photo to accessory from local machine
    path(
        "/<int:pk>/remove_photo", AccessoryRemovePhotoView.as_view(), name='remove_photo'
    ), # allow remove photo from accessory
    path(
            "/<int:pk>/update", AccessoryUpdateView.as_view(), name='update_accessory'
    ), # update accessory by id

]