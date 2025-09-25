from django.utils.decorators import method_decorator
from django.core.exceptions import ValidationError

from rest_framework import viewsets, status
from rest_framework.permissions import IsAuthenticated, AllowAny, IsAdminUser
from rest_framework.response import Response
from drf_yasg.utils import swagger_auto_schema
from rest_framework.views import APIView
from drf_yasg import openapi

from .models import Order
from .services.order_service import create_order
from .serializers import OrderWriteSerializer, OrderReadSerializer

from core.services.novaposhta_service import NovaPoshtaService

class CreateOrderView(viewsets.GenericViewSet):
    """
    Create a new order (authenticated users only).
    """
    serializer_class = OrderWriteSerializer
    permission_classes = (IsAuthenticated,)
    queryset = Order.objects.all()

    @swagger_auto_schema(
        operation_id="create_new_order",
        request_body=OrderWriteSerializer,
        responses={201: OrderWriteSerializer()}
    )
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        try:
            order = create_order(
                data=serializer.validated_data
            )
        except ValidationError as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
        except Exception:
            return Response({"error": "Internal server error"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        read_serializer = OrderReadSerializer(order)
        return Response(read_serializer.data, status=status.HTTP_201_CREATED)


class ListOrdersView(viewsets.ReadOnlyModelViewSet):
    """
    List all orders (admin only).
    """
    queryset = Order.objects.prefetch_related()
    serializer_class = OrderReadSerializer
    permission_classes = (IsAuthenticated,)

    def get_permissions(self):
        if self.request.method in ['GET']:
            self.permission_classes = [IsAuthenticated,]  # Change to IsAdminUser if needed
        return super().get_permissions()
    

class TrackTTNView(APIView):
    """
    Endpoint for tracking NovaPoshta TTN (waybill).
    """
    permission_classes = (IsAuthenticated,)

    def get(self, request, *args, **kwargs):
        ttn = request.query_params.get("ttn")

        if not ttn:
            return Response(
                {"error": "Missing required parameter: ttn"},
                status=status.HTTP_400_BAD_REQUEST
            )

        result = NovaPoshtaService.track_ttn(ttn)

        if result.get("success"):
            return Response(result, status=status.HTTP_200_OK)
        else:
            return Response(result, status=status.HTTP_400_BAD_REQUEST)
        
        
class DetailsOrderView(viewsets.ReadOnlyModelViewSet):
    """
    Retrieve order details (authenticated users only).
    """
    queryset = Order.objects.all()
    serializer_class = OrderReadSerializer
    permission_classes = (IsAuthenticated,)

    def get_permissions(self):
        if self.request.method in ['GET']:
            self.permission_classes = [IsAuthenticated,]
        return super().get_permissions()
    
    def get(self, request, *args, **kwargs):
        order_id = kwargs.get('pk')
        try:
            order = Order.objects.get(id=order_id, customer=request.user)
        except Order.DoesNotExist:
            return Response({"error": "Order not found"}, status=status.HTTP_404_NOT_FOUND)

        serializer = self.get_serializer(order)
        return Response(serializer.data, status=status.HTTP_200_OK)


class UpdateOrderView(viewsets.GenericViewSet):
    """
    Update order status or notes (admin only).
    """
    serializer_class = OrderWriteSerializer
    permission_classes = [IsAdminUser]
    queryset = Order.objects.all()

    def get_permissions(self):
        if self.request.method in ['PATCH', 'PUT']:
            self.permission_classes = [IsAdminUser]
        return super().get_permissions()

    @swagger_auto_schema(auto_schema=None)
    def partial_update(self, request, *args, **kwargs):
        order = self.get_object() 

        serializer = self.get_serializer(order, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        read_serializer = OrderReadSerializer(order)
        return Response(read_serializer.data, status=status.HTTP_200_OK)
