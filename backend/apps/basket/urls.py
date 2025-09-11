from django.urls import path
from .views import (
    ActiveBasketView,
    AddBasketItemView,
    UpdateBasketItemView,
    DeleteBasketItemView,
)

app_name = 'basket'

urlpatterns = [
    path('', ActiveBasketView.as_view(), name='basket_summary'),
    path('add/', AddBasketItemView.as_view(), name='basket_add'),
    path('update/', UpdateBasketItemView.as_view(), name='basket_update'),
    path('delete/', DeleteBasketItemView.as_view(), name='basket_delete'),
]