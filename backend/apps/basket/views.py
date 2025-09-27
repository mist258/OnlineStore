from django.utils.decorators import method_decorator

from rest_framework import generics, status
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from drf_yasg.utils import swagger_auto_schema

from apps.basket.models import Basket, BasketItem
from apps.basket.serializers import BasketSerializer, BasketItemSerializer
from apps.basket.services.basket_service import get_or_create_basket
import uuid


@method_decorator(name='get', decorator=swagger_auto_schema(
    operation_id='get_active_basket',
    responses={200: BasketSerializer()},
))
class ActiveBasketView(generics.GenericAPIView):
    serializer_class = BasketSerializer
    permission_classes = (AllowAny,)

    def get(self, request, *args, **kwargs):
        # Create response object
        response = Response()
        
        # Service handles all auth/guest logic and cookie setting
        basket = get_or_create_basket(request, response)
        
        # Serialize and return
        serializer = BasketSerializer(basket)
        response.data = serializer.data
        response.status_code = status.HTTP_200_OK
        return response


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

    def perform_create(self, serializer):
        # Check if user is properly authenticated
        if self.request.user.is_authenticated:
            # Authenticated user path
            basket = get_or_create_basket(request=self.request)
            serializer.save(basket=basket, user=self.request.user)
        else:
            # Guest user path
            response = Response()  # Create response to handle cookies
            basket = get_or_create_basket(request=self.request, response=response)
            serializer.save(basket=basket)
            
            # If new guest token was created, we need to set the cookie
            # This requires overriding the create method instead

    def create(self, request, *args, **kwargs):
        """Override to handle guest cookie setting"""
        response = Response()
        
        if request.user.is_authenticated:
            # Standard authenticated flow
            basket = get_or_create_basket(request=request)
        else:
            # Guest flow with cookie handling
            basket = get_or_create_basket(request=request, response=response)
        
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save(basket=basket)
        
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
    serializer_class = BasketItemSerializer
    permission_classes = (AllowAny,)  # guests allowed too

    def get_queryset(self):
        basket = get_or_create_basket(self.request)
        return BasketItem.objects.filter(basket=basket)


@method_decorator(name='delete', decorator=swagger_auto_schema(
    operation_id='delete_basket_item',
))
class DeleteBasketItemView(generics.DestroyAPIView):
    """
    Remove a specific item from the basket.
    """
    serializer_class = BasketItemSerializer
    permission_classes = (AllowAny,)
    
    def get_queryset(self):
        """Filter items to only those in the user's basket"""
        basket = get_or_create_basket(self.request)
        return BasketItem.objects.filter(basket=basket)


@method_decorator(name='delete', decorator=swagger_auto_schema(
    operation_id='clear_basket',
))
class ClearBasketView(generics.DestroyAPIView):
    """
    Clear all items from the active basket.
    """
    permission_classes = (AllowAny,)

    def delete(self, request, *args, **kwargs):
        basket = get_or_create_basket(request)
        basket.items.all().delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
