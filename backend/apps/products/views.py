from django.http import JsonResponse

from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.database_products.models import Product

from .serializers import ProductSerializer
from .services.product_service import get_product_all


def healthcheck(request):
    return JsonResponse({'status': 'Deployment is ready & API is working!'})


class ProductListAPIView(generics.ListAPIView):
    queryset = Product.objects.prefetch_related('photos', 'supplies').all()
    serializer_class = ProductSerializer