from django.urls import path

from .views import AccessoryByIdView, AccessoryCreateView, AccessoryListView

urlpatterns = [
    path(
        '', AccessoryListView.as_view(), name='list_accessories'
    ), # display a list of all accessories
    path(
        "/<int:pk>", AccessoryByIdView.as_view(), name='accessory_by_id'
    ), # display a specific accessory by its id
    path(
        "new_accessory", AccessoryCreateView.as_view(), name='add_accessory'
    ) # add new accessory

]