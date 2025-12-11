from django.urls import reverse

from rest_framework import status
from rest_framework.test import APIClient

from apps.basket.models import Basket, BasketItem
from apps.products.models import Accessory, Product
from apps.supplies.models import Supply
from apps.users.models import UserModel

import pytest


@pytest.mark.django_db
class TestActiveBasketView:
    def test_get_basket_authenticated(self, api_client, user):
        api_client.force_authenticate(user=user)
        url = reverse('basket:basket_summary')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert 'id' in response.data
        assert response.data['user'] == user.id
    
    def test_get_basket_guest(self, api_client):
        url = reverse('basket:basket_summary')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['user'] is None
        assert 'guest_token' in response.data


@pytest.mark.django_db
class TestAddBasketItemView:
    def test_add_item_authenticated(self, api_client, user, accessory, product, supply, basket):
        api_client.force_authenticate(user=user)
        url = reverse('basket:basket_add')
        
        data = {
            #'accessory_id': accessory.id,
            'product_id': product.id,
            'supply_id': supply.id,
            'basket_id': basket.id,
            'quantity': 2
        }
        
        response = api_client.post(url, data, format='json')
        print(f"============= {response.data}")
        assert response.status_code == status.HTTP_201_CREATED
        assert response.data['quantity'] == 2
        assert response.data['product_id'] == product.id
        assert response.data['supply_id'] == supply.id
        assert response.data['basket_id'] == basket.id

    def test_add_item_guest(self, api_client, product):
        url = reverse('basket:basket_add')
        
        data = {
            'product': product.id,
            'quantity': 1
        }
        
        response = api_client.post(url, data)
        
        assert response.status_code == status.HTTP_201_CREATED
        assert 'guest_token' in response.cookies
        assert response.data['quantity'] == 1


@pytest.mark.django_db
class TestUpdateBasketItemView:
    def test_update_item_quantity(self, api_client, user, product, basket):
        api_client.force_authenticate(user=user)
        basket_item = BasketItem.objects.create(
            basket=basket,
            quantity=1
        )
        
        data = {
            'quantity': 3
        }
        url = reverse('basket:basket_update', kwargs={'pk': basket_item.id})
        
        response = api_client.put(url, data)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['quantity'] == 3
        
    def test_partial_update_item(self, api_client, user, product, basket):
        api_client.force_authenticate(user=user)
        basket_item = BasketItem.objects.create(
            basket=basket,
            product=product,
            quantity=1
        )
        
        data = {
            'quantity': 2
        }
        url = reverse('basket:basket_update', kwargs={'pk': basket_item.id})
        
        response = api_client.patch(url, data)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['quantity'] == 2


@pytest.mark.django_db
class TestDeleteBasketItemView:
    def test_delete_item(self, api_client, user, product, basket):
        api_client.force_authenticate(user=user)
        basket_item = BasketItem.objects.create(
            basket=basket,
            product=product,
            quantity=1
        )
        
        data = {'id': basket_item.id}

        url = reverse('basket:basket_delete', kwargs={'pk': basket_item.id})
        response = api_client.delete(url, data)
        
        assert response.status_code == status.HTTP_204_NO_CONTENT
        assert not BasketItem.objects.filter(id=basket_item.id).exists()

    def test_delete_nonexistent_item(self, api_client, user):
        api_client.force_authenticate(user=user)
        data = {'id': 99999}

        url = reverse('basket:basket_delete', kwargs={'pk': 99999})
        response = api_client.delete(url, data)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND

    
@pytest.mark.django_db
class TestClearBasketView:
    def test_clear_authenticated_user_basket(self, api_client, user, basket):
        api_client.force_authenticate(user=user)
        url = reverse("basket:basket_clear")
        response = api_client.delete(url)

        assert response.status_code == status.HTTP_204_NO_CONTENT
        assert basket.items.count() == 0

    def test_clear_guest_basket(self, api_client, guest_basket):
        url = reverse("basket:basket_clear")
        response = api_client.delete(url)

        guest_basket.refresh_from_db()
        assert response.status_code == status.HTTP_204_NO_CONTENT
        assert guest_basket.items.count() == 0
        
    def test_anonymous_user_can_create_basket(self, api_client):
        url = reverse('basket:basket_summary')
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert 'guest_token' in response.cookies

    def test_authenticated_user_cannot_access_other_user_basket(
        self, api_client, user, other_user
    ):
        api_client.force_authenticate(user=other_user)
        
        url = reverse('basket:basket_summary')
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['user'] == other_user.id
        assert response.data['user'] != user.id