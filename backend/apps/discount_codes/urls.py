from django.urls import path

from .views import DiscountCodeViewSet

app_name = 'discount_codes'

urlpatterns = [
    path('/create/', DiscountCodeViewSet.as_view({'post': 'create'}), name="create_discount_code"),
    path('/<str:code>/', DiscountCodeViewSet.as_view({'get': 'retrieve', 'put': 'update', 'patch': 'update', 'delete': 'destroy'}), name="discount_code_detail"),
    path('/<str:code>/<int:order_id>/', DiscountCodeViewSet.as_view({'get': 'retrieve'}), name="get_discount_code_with_order"),
]
