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


@pytest.mark.django_db
class TestAddBasketItemView:
    def test_add_item_authenticated(self, api_client, user, accessory, product, supply, basket):
        api_client.force_authenticate(user=user)
        url = reverse('basket:basket_add')
        
        data = {
            # 'accessory_id': accessory.id,
            'product_id': product.id,
            'supply_id': supply.id,
            'quantity': 2
        }
        
        response = api_client.post(url, data, format='json')
        print(f"============= {response.data}")
        assert response.status_code == status.HTTP_201_CREATED
        assert response.data['quantity'] == 2
        assert response.data['product_id'] == product.id
        assert response.data['supply_id'] == supply.id


@pytest.mark.django_db
class TestUpdateBasketItemView:
    def test_update_item_quantity(self, basket, api_client, user, basket_item):
        api_client.force_authenticate(user=user)
        
        data = {
            'quantity': 3
        }
        url = reverse('basket:basket_update', kwargs={
            'basket_item_id': basket_item.id
        })
        
        response = api_client.put(url, data)

        assert response.status_code == status.HTTP_200_OK
        assert response.data['quantity'] == 3
        
        # check out of stock
        data = {
            'quantity': 12
        }
        
        response = api_client.put(url, data)
        
        assert response.status_code == status.HTTP_400_BAD_REQUEST


@pytest.mark.django_db
class TestDeleteBasketItemView:
    def test_delete_item_authenticated(self, api_client, user, basket, basket_item):
        api_client.force_authenticate(user=user)
        url = reverse('basket:basket_delete', kwargs={
            'basket_item_id': basket_item.id,
        })
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_204_NO_CONTENT
        assert not BasketItem.objects.filter(id=basket_item.id).exists()

    
@pytest.mark.django_db
class TestClearBasketView:
    def test_clear_authenticated_user_basket(self, api_client, user, basket):
        api_client.force_authenticate(user=user)
        url = reverse("basket:basket_clear", kwargs={
            'pk': basket.id
        })
        response = api_client.delete(url)
        assert response.status_code == status.HTTP_204_NO_CONTENT
        assert basket.items.count() == 0

    def test_authenticated_user_cannot_access_other_user_basket(
        self, api_client, user, other_user
    ):
        api_client.force_authenticate(user=other_user)
        
        url = reverse('basket:basket_summary')
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['user'] == other_user.id
        assert response.data['user'] != user.id