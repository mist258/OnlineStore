from rest_framework import permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.db_utils import get_object_or_error
from apps.favorites.services.favorites_service import FavoritesService
from apps.products.models import Accessory, Product
from apps.supplies.models import Supply


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
        return Response({"count": len(data), "items": data})

    def delete(self, request):
        """
        Clear all items from user's favorites
        """
        favorites = FavoritesService.get_or_create_favorites(request.user)
        FavoritesService.clear_favorites(favorites)
        return Response(status=status.HTTP_204_NO_CONTENT)


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

        item = get_object_or_error(model_map[item_type], id=item_id)
        favorites = FavoritesService.get_or_create_favorites(request.user)

        favorite_item, added = FavoritesService.toggle_item_in_favorites(favorites, item)
        return Response(
            {
                "item_id": item_id,
                "item_type": item_type,
                "added": added,
            },
            status=status.HTTP_200_OK,
        )


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

        item = get_object_or_error(model_map[item_type], id=item_id)
        favorites = FavoritesService.get_or_create_favorites(request.user)
        exists = FavoritesService.check_if_item_in_favorites(favorites, item)

        return Response(
            {
                "item_id": item_id,
                "item_type": item_type,
                "in_favorites": exists,
            }
        )


class FavoritesCountView(APIView):
    """
    Return total number of items in user's favorites
    """
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        favorites = FavoritesService.get_or_create_favorites(request.user)
        count = FavoritesService.get_favorites_count(favorites)
        return Response({"count": count})
