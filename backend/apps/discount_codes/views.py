import uuid

from django.utils.decorators import method_decorator

from rest_framework import generics, status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAdminUser, IsAuthenticated
from rest_framework.response import Response

from apps.db_utils import get_object_or_error
from apps.discount_codes.models import DiscountCode
from apps.discount_codes.serializers import AdminDiscountCodesSerializer, DiscountCodesSerializer
from apps.orders.models import Order

from drf_yasg.utils import swagger_auto_schema


class DiscountCodeViewSet(viewsets.GenericViewSet):
    """
    Manage discount codes: retrieve, create, update, and delete.
    """
    queryset = DiscountCode.objects.all()
    lookup_field = 'code'
    
    def get_permissions(self):
        if self.action == 'retrieve':
            return [AllowAny()]
        return [IsAdminUser()]
    
    def get_serializer_class(self):
        if self.action == 'retrieve':
            return DiscountCodesSerializer
        return AdminDiscountCodesSerializer
    
    @method_decorator(decorator=swagger_auto_schema(
        operation_id='get_discount_code',
        responses={200: DiscountCodesSerializer()},
    ))
    def retrieve(self, request, *args, **kwargs):
        """
        Retrieve details about a discount code.
        """
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
                "appy_discount_sum": discount.apply_discount(order.get_order_amount()) if order else None
            }
            return Response(data, status=status.HTTP_200_OK)
        except DiscountCode.DoesNotExist:
            return Response({"error": "Invalid or expired discount code"}, status=status.HTTP_404_NOT_FOUND)
    
    def create(self, request, *args, **kwargs):
        """
        Create a discount code from the admin panel.
        """
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        discount = serializer.save()
        return Response(
            AdminDiscountCodesSerializer(discount).data,
            status=status.HTTP_201_CREATED
        )
    
    def update(self, request, *args, **kwargs):
        """
        Update a discount code (PUT/PATCH).
        """
        try:
            discount = DiscountCode.objects.get(code=kwargs.get('code'))
        except DiscountCode.DoesNotExist:
            return Response(
                {"error": "Discount code not found"},
                status=status.HTTP_404_NOT_FOUND
            )
        
        partial = request.method == 'PATCH'
        serializer = self.get_serializer(discount, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        discount = serializer.save()
        
        return Response(
            AdminDiscountCodesSerializer(discount).data,
            status=status.HTTP_200_OK
        )
    
    def destroy(self, request, *args, **kwargs):
        """
        Delete a discount code.
        """
        try:
            discount = DiscountCode.objects.get(code=kwargs.get('code'))
            discount.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        except DiscountCode.DoesNotExist:
            return Response(
                {"error": "Discount code not found"},
                status=status.HTTP_404_NOT_FOUND
            )