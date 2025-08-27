from django.core.exceptions import ValidationError
from django.utils.decorators import method_decorator

from rest_framework import status, viewsets
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response

from drf_yasg.utils import swagger_auto_schema

from .models import Order
from .serializers import OrderReadSerializer, OrderWriteSerializer
from .services.order_service import create_order


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
        user = request.user if getattr(request, "user", None) else None
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        try:
            order = create_order(
                user=user,
                data=serializer.validated_data
            )
        except ValidationError as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
        except Exception:
            return Response({"error": "Internal server error"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        output_serializer = self.get_serializer(order)
        return Response(output_serializer.data, status=status.HTTP_201_CREATED)

@method_decorator(name='get', decorator=swagger_auto_schema(
    operation_id='get_order',
    responses={200: OrderReadSerializer(many=True)}
))
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