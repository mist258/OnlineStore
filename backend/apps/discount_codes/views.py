import uuid

from django.utils.decorators import method_decorator

from rest_framework import generics, status, viewsets
from rest_framework.permissions import AllowAny, IsAdminUser, IsAuthenticated
from rest_framework.response import Response

from apps.db_utils import get_object_or_error
from apps.discount_codes.models import DiscountCode
from apps.discount_codes.serializers import DiscountCodesSerializer
from apps.orders.models import Order

from drf_yasg.utils import swagger_auto_schema


@method_decorator(name='get', decorator=swagger_auto_schema(
    operation_id='get_discount_code',
    responses={200: DiscountCodesSerializer()},
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


class CreateDiscountCodeView(viewsets.GenericViewSet):
    """
    Apply a discount code to the active basket.
    """
    permission_classes = (IsAdminUser,)
    
    @swagger_auto_schema(
        operation_id="create_new_order",
        request_body=DiscountCodesSerializer,
        responses={201: DiscountCodesSerializer()}
    )
    def create(self, request, *args, **kwargs):
        code = kwargs.get('code', None)
        if not code:
            return Response({"error": "Code parameter is required"}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            discount = DiscountCode.objects.get(code=code)
            if not discount.is_valid():
                return Response({"error": "Discount code is not valid"}, status=status.HTTP_400_BAD_REQUEST)
            
            discount.save()
            
            serializer = DiscountCodesSerializer(discount)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except DiscountCode.DoesNotExist:
            return Response({"error": "Invalid or expired discount code"}, status=status.HTTP_404_NOT_FOUND)
        
