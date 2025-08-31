from django.urls import path

from .views import CreateOrderView, ListOrdersView, TrackTTNView

urlpatterns = [
    path(
      '/track-ttn/', TrackTTNView.as_view(), name='track_ttn'
    ),
    path(
        '/create', CreateOrderView.as_view({'post': 'create'}), name='create_order'
    ),
    path(
        '/list', ListOrdersView.as_view({'get': 'list'}), name='list_orders'
    ),
]
