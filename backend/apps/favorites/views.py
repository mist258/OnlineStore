from django.utils.decorators import method_decorator

from rest_framework import permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.db_utils import get_object_or_error
from apps.favorites.services.favorites_service import FavoritesService
from apps.products.models import Accessory, Product
from apps.supplies.models import Supply

from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema

from .serializers import FavoritesSerializer


@method_decorator(name='get', decorator=swagger_auto_schema(
    operation_id='list_favorites',
    responses={
        200: FavoritesSerializer(),
        401: 'Unauthorized'
    }
))
@method_decorator(name='delete', decorator=swagger_auto_schema(
    operation_id='clear_favorites',
    responses={
        204: 'No Content',
        401: 'Unauthorized'
    }
))
class FavoritesView(APIView):
    """
    Handle listing and clearing of user's favorites
    """
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        """
        Return all items in the authenticated user's favorites
        """
        favorites = FavoritesService.get_or_create_favorites(request.user)
        items = favorites.items.all()
        data = [
            {
                "id": item.id,
                "product": item.product.id if item.product else None,
                "accessory": item.accessory.id if item.accessory else None,
                "supply": item.supply.id if item.supply else None,
            }
            for item in items
        ]
        return Response({"count": len(data), "items": data, "user": request.user.id})

    def delete(self, request):
        """
        Clear all items from user's favorites
        """
        favorites = FavoritesService.get_or_create_favorites(request.user)
        FavoritesService.clear_favorites(favorites)
        return Response(status=status.HTTP_204_NO_CONTENT)


@method_decorator(name='post', decorator=swagger_auto_schema(
    operation_id='toggle_favorite_item',
    manual_parameters=[
        openapi.Parameter(
            'item_type',
            openapi.IN_PATH,
            description="Type of item (product/accessory/supply)",
            type=openapi.TYPE_STRING,
            enum=['product', 'accessory', 'supply']
        ),
        openapi.Parameter(
            'item_id',
            openapi.IN_PATH,
            description="ID of the item",
            type=openapi.TYPE_INTEGER
        ),
    ],
    responses={
        201: 'Item added to favorites',
        200: 'Item removed from favorites',
        400: 'Invalid item type',
        401: 'Unauthorized',
        404: 'Item not found'
    }
))
class ToggleFavoriteView(APIView):
    """
    Toggle an item (Product / Accessory / Supply) in favorites
    """
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, item_type: str, item_id: int):
        """
        Add or remove an item from favorites
        """
        model_map = {
            "product": Product,
            "accessory": Accessory,
            "supply": Supply,
        }

        if item_type not in model_map:
            return Response(
                {"detail": "Invalid item type."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        item = get_object_or_error(model_map[item_type], object_id=item_id)
        favorites = FavoritesService.get_or_create_favorites(request.user)

        favorite_item, added = FavoritesService.toggle_item_in_favorites(favorites, item)
        return Response(
            {
                "item_id": item_id,
                "item_type": item_type,
                "added": added,
            },
            status=status.HTTP_201_CREATED if added else status.HTTP_200_OK,
        )


@method_decorator(name='get', decorator=swagger_auto_schema(
    operation_id='check_favorite_item',
    manual_parameters=[
        openapi.Parameter(
            'item_type',
            openapi.IN_PATH,
            description="Type of item (product/accessory/supply)",
            type=openapi.TYPE_STRING,
            enum=['product', 'accessory', 'supply']
        ),
        openapi.Parameter(
            'item_id',
            openapi.IN_PATH,
            description="ID of the item",
            type=openapi.TYPE_INTEGER
        ),
    ],
    responses={
        200: openapi.Response(
            description="Check result",
            schema=openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'item_id': openapi.Schema(type=openapi.TYPE_INTEGER),
                    'item_type': openapi.Schema(type=openapi.TYPE_STRING),
                    'in_favorites': openapi.Schema(type=openapi.TYPE_BOOLEAN),
                }
            )
        ),
        400: 'Invalid item type',
        401: 'Unauthorized',
        404: 'Item not found'
    }
))
class CheckFavoriteView(APIView):
    """
    Check if a specific item is in user's favorites
    """
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, item_type: str, item_id: int):
        model_map = {
            "product": Product,
            "accessory": Accessory,
            "supply": Supply,
        }

        if item_type not in model_map:
            return Response(
                {"detail": "Invalid item type."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        item = get_object_or_error(model_map[item_type], object_id=item_id)
        favorites = FavoritesService.get_or_create_favorites(request.user)
        exists = FavoritesService.check_if_item_in_favorites(favorites, item)

        return Response(
            {
                "item_id": item_id,
                "item_type": item_type,
                "in_favorites": exists,
            }
        )


@method_decorator(name='get', decorator=swagger_auto_schema(
    operation_id='get_favorites_count',
    responses={
        200: openapi.Response(
            description="Favorites count",
            schema=openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'count': openapi.Schema(type=openapi.TYPE_INTEGER),
                }
            )
        ),
        401: 'Unauthorized'
    }
))
class FavoritesCountView(APIView):
    """
    Return total number of items in user's favorites
    """
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        favorites = FavoritesService.get_or_create_favorites(request.user)
        count = FavoritesService.get_favorites_count(favorites)
        return Response({"count": count})
