from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import ProductSerializer
from .services.product_service import get_product_all
from django.http import JsonResponse


def healthcheck(request):
    return JsonResponse({'status': 'Deployment is ready & API is working!'})


class ProductListAPIView(APIView):
    def get(self, request):
        try:
            products = get_product_all()
            if not products:
                return Response({'message': 'No products found'}, status=404)
            start = request.query_params.get('start')
            end = request.query_params.get('end')
            if start is not None and end is not None:
                start = int(start)
                end = int(end)

                if start < 0 or end <= start:
                    return Response({'error': 'Invalid range: start must be >= 0 and end > start'}, status=status.HTTP_400_BAD_REQUEST)

                products = products[start:end]

            serializer = ProductSerializer(products, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except ValueError:
            return Response({'error': 'Start and end must be integers'}, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)