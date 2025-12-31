from django.urls import path

from .views import (
    CreateOrderView,
    DeleteOrderView,
    DetailsOrderView,
    ListOrdersView,
    ListUserOrdersView,
    TrackTTNView,
    UpdateOrderView,
)

app_name = 'orders'

urlpatterns = [
    path('/create/', CreateOrderView.as_view({'post': 'create'}), name='create_order'),
    path('/update/<int:pk>/', UpdateOrderView.as_view({'patch': 'partial_update'}), name='update_order'),
    path('/delete/<int:pk>/', DeleteOrderView.as_view({'delete': 'destroy'}), name='delete_order'),
    path('/admin-list/', ListOrdersView.as_view({'get': 'list'}), name='list_orders'),
    path('/user-list/', ListUserOrdersView.as_view({'get': 'list_user_orders'}), name='user_orders'),
    path('/details/<int:pk>/', DetailsOrderView.as_view({'get': 'retrieve'}), name='details_order'),
    path('/track-ttn/', TrackTTNView.as_view(), name='track_ttn'),
]
