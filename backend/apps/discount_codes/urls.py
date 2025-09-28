from django.urls import path
from .views import (
    GetDiscountCodeView,
    CreateDiscountCodeView
)

app_name = 'discount_codes'

urlpatterns = [
    path("/<str:code>/", GetDiscountCodeView.as_view(), name="get_discount_code"),
    path("/<str:code>/<int:order_id>/", GetDiscountCodeView.as_view(), name="get_discount_code_with_order"),
    path("/create/", CreateDiscountCodeView.as_view(), name="create_discount_code"),
 ]

 





