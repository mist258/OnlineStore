from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import ProductSerializer
from .services.product_service import get_product_all
from django.http import JsonResponse
from apps.database_products.models import Product
from rest_framework import generics


def healthcheck(request):
    return JsonResponse({'status': 'Deployment is ready & API is working!'})


class ProductListAPIView(generics.ListAPIView):
    queryset = Product.objects.prefetch_related('photos', 'supplies').all()
    serializer_class = ProductSerializer