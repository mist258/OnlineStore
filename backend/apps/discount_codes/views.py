from django.utils.decorators import method_decorator

from rest_framework import generics, status
from rest_framework.permissions import IsAuthenticated, AllowAny, IsAdminUser
from rest_framework.response import Response
from drf_yasg.utils import swagger_auto_schema

from apps.orders.models import Order
from apps.basket.models import Basket, BasketItem, DiscountCode
from apps.basket.serializers import BasketSerializer, BasketItemSerializer
from apps.basket.services.basket_service import get_or_create_basket
from apps.db_utils import get_object_or_error
import uuid


@method_decorator(name='get', decorator=swagger_auto_schema(
    operation_id='get_discount_code',
))
class GetDiscountCodeView(generics.RetrieveAPIView):
    """
    Retrieve details about a discount code.
    """
    permission_classes = (AllowAny,)
    
    def get(self, request, *args, **kwargs):
        code = kwargs.get('code', None)
        if not code:
            return Response({"error": "Code parameter is required"}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            discount = DiscountCode.objects.get(code=code)
            order_id = kwargs.get('order_id', None)
            order = get_object_or_error(Order, object_id=order_id) if order_id else None
            data = {
                "code": discount.code,
                "description": discount.description,
                "discount_percent": discount.discount_percent,
                "active": discount.active,
                "is_valid": discount.is_valid(),
                "valid_from": discount.valid_from,
                "valid_to": discount.valid_to,
                "appy_discount": discount.apply_discount(order.get_order_amount()) if order else None
            }
            return Response(data, status=status.HTTP_200_OK)
        except DiscountCode.DoesNotExist:
            return Response({"error": "Invalid or expired discount code"}, status=status.HTTP_404_NOT_FOUND)


@method_decorator(name='post', decorator=swagger_auto_schema(
    operation_id='create_discount_code_to_basket',
))
class CreateDiscountCodeView(generics.CreateAPIView):
    """
    Apply a discount code to the active basket.
    """
    permission_classes = (IsAdminUser,)
    
    def post(self, request, *args, **kwargs):
        code = kwargs.get('code', None)
        if not code:
            return Response({"error": "Code parameter is required"}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            discount = DiscountCode.objects.get(code=code)
            if not discount.is_valid():
                return Response({"error": "Discount code is not valid"}, status=status.HTTP_400_BAD_REQUEST)
            
            basket = get_or_create_basket(request)
            basket.discount_code = discount
            basket.save()
            
            serializer = BasketSerializer(basket)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except DiscountCode.DoesNotExist:
            return Response({"error": "Invalid or expired discount code"}, status=status.HTTP_404_NOT_FOUND)
        
