from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import ProductSerializer
from .services.product_service import get_product_all
from django.http import JsonResponse


def healthcheck(request):
    return JsonResponse({'status': 'Deployment is ready & API is working!'})


class ProductListAPIView(APIView):
    def get(self, request):
        products = get_product_all()
        serializer = ProductSerializer(products, many=True)
        return Response(serializer.data)
