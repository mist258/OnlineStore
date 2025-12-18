import uuid

from django.utils.decorators import method_decorator

from rest_framework import generics, status
from rest_framework.permissions import AllowAny, IsAdminUser, IsAuthenticated
from rest_framework.response import Response

from apps.basket.models import Basket, BasketItem, DiscountCode
from apps.basket.serializers import BasketItemSerializer, BasketItemUpdateSerializer, BasketSerializer
from apps.db_utils import get_object_or_error
from apps.orders.models import Order

from drf_yasg.utils import swagger_auto_schema


@method_decorator(name='get', decorator=swagger_auto_schema(
    operation_id='get_active_basket',
    responses={200: BasketSerializer()},
))
class ActiveBasketView(generics.GenericAPIView):
    serializer_class = BasketSerializer
    permission_classes = (AllowAny,)
    
    def get(self, request, *args, **kwargs):
        basket, created = Basket.objects.get_or_create(
            user=request.user
        )

        serializer = self.get_serializer(basket)
        return Response(serializer.data, status=status.HTTP_200_OK)


@method_decorator(name='post', decorator=swagger_auto_schema(
    operation_id='add_item_to_basket',
    responses={201: BasketItemSerializer()},
))
class AddBasketItemView(generics.CreateAPIView):
    """
    Add a product to the active basket (or increase quantity if exists).
    Works for both authenticated users and guests.
    """
    serializer_class = BasketItemSerializer
    permission_classes = (AllowAny,)  # Allow both auth and guest users

    def create(self, request, *args, **kwargs):
        """Override to handle guest cookie setting"""
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        response = Response()
        
        if request.user.is_authenticated:
            serializer.save()
        else:
            # Guest flow with cookie handling
            # basket = get_or_create_basket(request=request, response=response)
            response.status_code = 401
            return response
        
        response.data = serializer.data
        response.status_code = status.HTTP_201_CREATED
        return response


@method_decorator(name='put', decorator=swagger_auto_schema(
    operation_id='update_basket_item',
    responses={200: BasketItemSerializer()},
))
@method_decorator(name='patch', decorator=swagger_auto_schema(
    operation_id='partial_update_basket_item',
    responses={200: BasketItemSerializer()},
))
class UpdateBasketItemView(generics.UpdateAPIView):
    """
    Update the quantity or product of an item inside the basket.
    Works for both authenticated users and guests.
    """
    serializer_class = BasketItemUpdateSerializer
    permission_classes = (IsAuthenticated,)
    lookup_url_kwarg = "basket_item_id"

    def get_queryset(self):
        basket = Basket.objects.get(user=self.request.user)
        return BasketItem.objects.filter(
            id=self.kwargs["basket_item_id"],
            basket=basket
        )

@method_decorator(name='delete', decorator=swagger_auto_schema(
    operation_id='delete_basket_item',
))
class DeleteBasketItemView(generics.DestroyAPIView):
    """
    Remove a specific item from the basket.
    """
    permission_classes = (IsAuthenticated,)
    lookup_url_kwarg = "basket_item_id"
    
    def get_queryset(self):
        """Filter items to only those in the user's basket"""
        basket = Basket.objects.get(user=self.request.user)

        return BasketItem.objects.filter(
            id=self.kwargs['basket_item_id'],
            basket=basket
        )


@method_decorator(name='delete', decorator=swagger_auto_schema(
    operation_id='clear_basket',
))
class ClearBasketView(generics.DestroyAPIView):
    """
    Clear all items from the active basket.
    """
    permission_classes = (IsAuthenticated,)
    
    def get_queryset(self):
        return Basket.objects.filter(
            id=self.kwargs['pk']
        )

    