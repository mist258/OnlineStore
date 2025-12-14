from django.urls import path

from .views import ActiveBasketView, AddBasketItemView, ClearBasketView, DeleteBasketItemView, UpdateBasketItemView

app_name = 'basket'

urlpatterns = [
    path('', ActiveBasketView.as_view(), name='basket_summary'),
    path('/add/', AddBasketItemView.as_view(), name='basket_add'),
    path('/update/basket_item/<int:basket_item_id>', UpdateBasketItemView.as_view(), name='basket_update'),
    path('/delete/basket_item/<int:basket_item_id>', DeleteBasketItemView.as_view(), name='basket_delete'),
    path('/clear/<int:pk>', ClearBasketView.as_view(), name='basket_clear'),
 ]

 