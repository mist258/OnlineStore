from django.urls import path

from .views import CreateOrderView, UpdateOrderView, ListOrdersView, DetailsOrderView, TrackTTNView

app_name = 'orders'

urlpatterns = [
    path('/create', CreateOrderView.as_view({'post': 'create'}), name='create_order'),
    path('/update/<int:pk>/', UpdateOrderView.as_view({'patch': 'partial_update'}), name='update_order'),
    path('/list', ListOrdersView.as_view({'get': 'list'}), name='list_orders'),
    path('/details/<int:pk>/', DetailsOrderView.as_view({'get': 'retrieve'}), name='details_order'),
    path('/track-ttn/', TrackTTNView.as_view(), name='track_ttn'),
]
