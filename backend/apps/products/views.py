from django.http import JsonResponse

from rest_framework import generics

from apps.products.models import Product

from .serializers import ProductSerializer


def healthcheck(request):
    return JsonResponse({'status': 'Deployment is ready & API is working!'})


class ProductListAPIView(generics.ListAPIView):
    queryset = Product.objects.prefetch_related('photos', 'supplies').all()
    serializer_class = ProductSerializer