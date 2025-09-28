from django.urls import path
from .views import (
    ActiveBasketView,
    AddBasketItemView,
    UpdateBasketItemView,
    DeleteBasketItemView,
    ClearBasketView,
    DiscountCodeView
)

app_name = 'basket'

urlpatterns = [
    path('', ActiveBasketView.as_view(), name='basket_summary'),
    path('/add/', AddBasketItemView.as_view(), name='basket_add'),
    path('/update/<int:pk>/', UpdateBasketItemView.as_view(), name='basket_update'),
    path('/delete/<int:pk>/', DeleteBasketItemView.as_view(), name='basket_delete'),
    path('/clear/', ClearBasketView.as_view(), name='basket_clear'),
    path("/discount/<str:code>/", DiscountCodeView.as_view(), name="basket_discount"),
    path("/discount/<str:code>/<int:order_id>/", DiscountCodeView.as_view(), name="basket_discount_with_order"),
]

 