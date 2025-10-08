import pytest
from django.urls import reverse
from rest_framework import status

import pytest


@pytest.mark.django_db
class TestFavoritesListView:
    def test_get_favorites_authenticated(self, api_client, user):
        api_client.force_authenticate(user=user)
        url = reverse('favorites:favorites-list')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert 'id' in response.data
        assert response.data['user'] == user.id
    
    def test_get_favorites_unauthenticated(self, api_client):
        url = reverse('favorites:favorites-list')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED


@pytest.mark.django_db
class TestFavoriteItemView:
    def test_add_item_to_favorites(self, api_client, user, product):
        api_client.force_authenticate(user=user)
        url = reverse('favorites-list')
        
        data = {
            'product': product.id
        }
        
        response = api_client.post(url, data)
        
        assert response.status_code == status.HTTP_201_CREATED
        assert response.data['product'] == product.id

    def test_add_accessory_to_favorites(self, api_client, user, accessory):
        api_client.force_authenticate(user=user)
        url = reverse('favorites:favorite-items-list')
        
        data = {
            'accessory': accessory.id
        }
        
        response = api_client.post(url, data)
        
        assert response.status_code == status.HTTP_201_CREATED
        assert response.data['accessory'] == accessory.id

    def test_add_supply_to_favorites(self, api_client, user, supply):
        api_client.force_authenticate(user=user)
        url = reverse('favorites:favorite-items-list')
        
        data = {
            'supply': supply.id
        }
        
        response = api_client.post(url, data)
        
        assert response.status_code == status.HTTP_201_CREATED
        assert response.data['supply'] == supply.id


@pytest.mark.django_db
class TestToggleFavoriteView:
    def test_toggle_item_add(self, api_client, user, favorites, product):
        api_client.force_authenticate(user=user)
        url = reverse('favorites:favorites-toggle-item', kwargs={'pk': favorites.id})
        
        data = {
            'product': product.id
        }
        
        response = api_client.post(url, data)
        
        assert response.status_code == status.HTTP_201_CREATED
        assert response.data['product'] == product.id

    def test_toggle_item_remove(self, api_client, user, favorites, product):
        api_client.force_authenticate(user=user)
        url = reverse('favorites:favorites-toggle-item', kwargs={'pk': favorites.id})
        
        # Add item first
        data = {'product': product.id}
        api_client.post(url, data)
        
        # Toggle remove
        response = api_client.post(url, data)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['status'] == 'item removed'


@pytest.mark.django_db
class TestDeleteFavoriteItemView:
    def test_delete_favorite_item(self, api_client, user, favorites, product):
        api_client.force_authenticate(user=user)
        # Add item to favorites first
        favorite_item = FavoritesService.add_item_to_favorites(favorites, product)
        
        url = reverse('favorites:favorite-items-detail', kwargs={'pk': favorite_item.id})
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_204_NO_CONTENT
        assert not FavoriteItem.objects.filter(id=favorite_item.id).exists()

    def test_delete_nonexistent_item(self, api_client, user):
        api_client.force_authenticate(user=user)
        url = reverse('favorites:favorite-items-detail', kwargs={'pk': 99999})
        
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND


@pytest.mark.django_db
class TestClearFavoritesView:
    def test_clear_favorites(self, api_client, user, favorites, product, accessory):
        api_client.force_authenticate(user=user)
        # Add items to favorites
        FavoritesService.add_item_to_favorites(favorites, product)
        FavoritesService.add_item_to_favorites(favorites, accessory)
        
        url = reverse('favorites:favorites-clear', kwargs={'pk': favorites.id})
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_204_NO_CONTENT
        assert favorites.items.count() == 0

    def test_clear_favorites_unauthorized(self, api_client, favorites):
        url = reverse('favorites:favorites-clear', kwargs={'pk': favorites.id})
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED


@pytest.mark.django_db
class TestFavoritesPermissions:
    def test_user_cannot_access_other_user_favorites(
        self, api_client, user, other_user, favorites
    ):
        api_client.force_authenticate(user=other_user)
        url = reverse('favorites:favorites-detail', kwargs={'pk': favorites.id})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND

    def test_unauthenticated_user_cannot_access_favorites(
        self, api_client, favorites
    ):
        url = reverse('favorites:favorites-detail', kwargs={'pk': favorites.id})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED