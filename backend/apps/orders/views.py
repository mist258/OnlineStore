from django.http import Http404

from rest_framework import status, viewsets
from rest_framework.permissions import IsAdminUser, IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from core.services.novaposhta_service import NovaPoshtaService

from drf_yasg.utils import swagger_auto_schema

from .models import Order
from .serializers import OrderReadSerializer, OrderWriteSerializer


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
        serializer.save()
        
        return Response(serializer.data, status=status.HTTP_201_CREATED)


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
    serializer_class = OrderReadSerializer
    permission_classes = (IsAuthenticated,)

    def get_queryset(self):
        return Order.objects.filter(customer=self.request.user)

    def retrieve(self, request, *args, **kwargs):
        try:
            return super().retrieve(request, *args, **kwargs)
        except Http404:
            return Response({"error": "Order not found"}, status=status.HTTP_404_NOT_FOUND)


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

        try:
            serializer.is_valid(raise_exception=True)
        except Exception as e:
            print(">>> Serializer validation failed:", e)
            raise

        try:
            serializer.save()
        except Exception as e:
            raise

        read_serializer = OrderReadSerializer(order)

        return Response(read_serializer.data, status=status.HTTP_200_OK)


class DeleteOrderView(viewsets.GenericViewSet):
    """
    Delete an order (admin only).
    """
    serializer_class = OrderReadSerializer
    permission_classes = [IsAdminUser]
    queryset = Order.objects.all()

    def destroy(self, request, *args, **kwargs):
        order = self.get_object()
        order.delete()
        return Response({"message": "Order deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
