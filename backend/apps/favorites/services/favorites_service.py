from typing import Union

from django.contrib.auth import get_user_model
from django.db import transaction

from apps.favorites.models import FavoriteItem, Favorites
from apps.products.models import Accessory, Product
from apps.supplies.models import Supply

User = get_user_model()

class FavoritesService:
    @staticmethod
    def get_or_create_favorites(user: User) -> Favorites:
        """
        Get existing favorites for user or create new one
        """
        favorites, _ = Favorites.objects.get_or_create(user=user)
        return favorites

    @staticmethod
    def add_item_to_favorites(
        favorites: Favorites,
        item: Union[Product, Accessory, Supply]
    ) -> FavoriteItem:
        """
        Add an item to user's favorites
        """
        item_type = type(item).__name__.lower()
        item_data = {f"{item_type}": item}
        
        favorite_item, created = FavoriteItem.objects.get_or_create(
            favorites=favorites,
            **item_data
        )
        return favorite_item

    @staticmethod
    def remove_item_from_favorites(
        favorites: Favorites,
        item: Union[Product, Accessory, Supply]
    ) -> bool:
        """
        Remove an item from user's favorites
        Returns True if item was removed, False if it wasn't found
        """
        item_type = type(item).__name__.lower()
        item_data = {f"{item_type}": item}
        
        try:
            favorite_item = FavoriteItem.objects.get(
                favorites=favorites,
                **item_data
            )
            favorite_item.delete()
            return True
        except FavoriteItem.DoesNotExist:
            return False

    @staticmethod
    def toggle_item_in_favorites(
        favorites: Favorites,
        item: Union[Product, Accessory, Supply]
    ) -> tuple[FavoriteItem, bool]:
        """
        Toggle item in favorites (add if not present, remove if present)
        Returns tuple of (FavoriteItem, bool) where bool indicates if item was added
        """
        item_type = type(item).__name__.lower()
        item_data = {f"{item_type}": item}
        
        try:
            favorite_item = FavoriteItem.objects.get(
                favorites=favorites,
                **item_data
            )
            favorite_item.delete()
            return None, False
        except FavoriteItem.DoesNotExist:
            favorite_item = FavoriteItem.objects.create(
                favorites=favorites,
                **item_data
            )
            return favorite_item, True

    @staticmethod
    def clear_favorites(favorites: Favorites) -> None:
        """
        Remove all items from favorites
        """
        with transaction.atomic():
            favorites.items.all().delete()

    @staticmethod
    def check_if_item_in_favorites(
        favorites: Favorites,
        item: Union[Product, Accessory, Supply]
    ) -> bool:
        """
        Check if an item is in user's favorites
        """
        item_type = type(item).__name__.lower()
        item_data = {f"{item_type}": item}
        
        return FavoriteItem.objects.filter(
            favorites=favorites,
            **item_data
        ).exists()

    @staticmethod
    def get_favorites_count(favorites: Favorites) -> int:
        """
        Get total number of items in favorites
        """
        return favorites.items.count()