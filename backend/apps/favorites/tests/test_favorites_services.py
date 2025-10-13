from django.contrib.auth import get_user_model
from django.test import TestCase

from apps.favorites.models import FavoriteItem, Favorites
from apps.favorites.services.favorites_service import FavoritesService
from apps.products.models import Accessory, Product
from apps.supplies.models import Supply

import pytest

User = get_user_model()

@pytest.mark.django_db
class TestFavoritesService:
    def test_toggle_item_in_favorites(self, favorites, product):
        # Test adding item
        item, added = FavoritesService.toggle_item_in_favorites(favorites, product)
        assert item is not None
        assert added is True
        assert favorites.items.count() == 1

        # Test removing same item
        item, added = FavoritesService.toggle_item_in_favorites(favorites, product)
        assert item is None
        assert added is False
        assert favorites.items.count() == 0

    def test_get_or_create_favorites(self, user):
        # Test creating new favorites
        favorites = FavoritesService.get_or_create_favorites(user)
        assert isinstance(favorites, Favorites)
        assert favorites.user == user

        # Test getting existing favorites
        same_favorites = FavoritesService.get_or_create_favorites(user)
        assert favorites == same_favorites

    def test_add_item_to_favorites(self, favorites, product, accessory, supply):
        # Test adding different types of items
        product_item = FavoritesService.add_item_to_favorites(favorites, product)
        assert isinstance(product_item, FavoriteItem)
        assert product_item.product == product

        accessory_item = FavoritesService.add_item_to_favorites(favorites, accessory)
        assert accessory_item.accessory == accessory

        supply_item = FavoritesService.add_item_to_favorites(favorites, supply)
        assert supply_item.supply == supply

    def test_remove_item_from_favorites(self, favorites, product):
        FavoritesService.add_item_to_favorites(favorites, product)

        # Test successful removal
        result = FavoritesService.remove_item_from_favorites(favorites, product)
        assert result is True
        assert favorites.items.count() == 0

        # Test removing non-existent item
        result = FavoritesService.remove_item_from_favorites(favorites, product)
        assert result is False

    def test_clear_favorites(self, favorites, product, accessory):
        FavoritesService.add_item_to_favorites(favorites, product)
        FavoritesService.add_item_to_favorites(favorites, accessory)
        
        assert favorites.items.count() == 2
        FavoritesService.clear_favorites(favorites)
        assert favorites.items.count() == 0

    def test_check_if_item_in_favorites(self, favorites, product, accessory):
        FavoritesService.add_item_to_favorites(favorites, product)

        # Test existing item
        assert FavoritesService.check_if_item_in_favorites(favorites, product) is True
        # Test non-existing item
        assert FavoritesService.check_if_item_in_favorites(favorites, accessory) is False

    def test_get_favorites_count(self, favorites, product, accessory):
        assert FavoritesService.get_favorites_count(favorites) == 0

        FavoritesService.add_item_to_favorites(favorites, product)
        assert FavoritesService.get_favorites_count(favorites) == 1

        FavoritesService.add_item_to_favorites(favorites, accessory)
        assert FavoritesService.get_favorites_count(favorites) == 2