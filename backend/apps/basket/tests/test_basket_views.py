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
        
        # Check price is correct
        expected_total_price = supply.price * data['quantity']
        assert response.data['total_price'] == f"{expected_total_price:.2f}"
        
    def test_add_item_with_different_quantities_and_prices(self, api_client, user, product, basket):
        """Test that the total price calculation is correct for different quantities"""
        api_client.force_authenticate(user=user)
        url = reverse('basket:basket_add')
        
        # Create supplies with different prices
        supply_1 = Supply.objects.create(product=product, price=50.00, quantity=20)
        supply_2 = Supply.objects.create(product=product, price=75.50, quantity=15)
        
        # Test with first supply
        data_1 = {
            'product_id': product.id,
            'supply_id': supply_1.id,
            'quantity': 3
        }
        response_1 = api_client.post(url, data_1, format='json')
        assert response_1.status_code == status.HTTP_201_CREATED
        assert response_1.data['total_price'] == f"{50.00 * 3:.2f}"
        
        # Test with second supply
        data_2 = {
            'product_id': product.id,
            'supply_id': supply_2.id,
            'quantity': 4
        }
        response_2 = api_client.post(url, data_2, format='json')
        assert response_2.status_code == status.HTTP_201_CREATED
        assert response_2.data['total_price'] == f"{75.50 * 4:.2f}"


@pytest.mark.django_db
class TestAddDuplicateBasketItemView:
    """Test that adding the same item twice increments quantity instead of creating duplicates"""
    
    def test_add_same_product_twice_increments_quantity(self, api_client, user, product, supply, basket):
        """Adding the same product/supply combination should increment quantity"""
        api_client.force_authenticate(user=user)
        url = reverse('basket:basket_add')
        
        # First request
        data = {
            'product_id': product.id,
            'supply_id': supply.id,
            'quantity': 2
        }
        response_1 = api_client.post(url, data, format='json')
        assert response_1.status_code == status.HTTP_201_CREATED
        first_item_id = response_1.data['id']
        assert response_1.data['quantity'] == 2
        assert response_1.data['total_price'] == f"{supply.price * 2:.2f}"
        
        # Add same item again with different quantity
        data['quantity'] = 3
        response_2 = api_client.post(url, data, format='json')
        assert response_2.status_code == status.HTTP_201_CREATED
        second_item_id = response_2.data['id']
        
        # Should be the same item with incremented quantity
        assert first_item_id == second_item_id
        assert response_2.data['quantity'] == 5  # 2 + 3
        assert response_2.data['total_price'] == f"{supply.price * 5:.2f}"
        
        # Verify only one BasketItem exists in database
        assert BasketItem.objects.filter(basket=basket).count() == 1
        basket_item = BasketItem.objects.get(basket=basket)
        assert basket_item.quantity == 5
    
    def test_add_same_accessory_twice_increments_quantity(self, api_client, user, accessory, basket):
        """Adding the same accessory twice should increment quantity"""
        api_client.force_authenticate(user=user)
        url = reverse('basket:basket_add')
        
        # First request
        data = {
            'accessory_id': accessory.id,
            'quantity': 1
        }
        response_1 = api_client.post(url, data, format='json')
        assert response_1.status_code == status.HTTP_201_CREATED
        first_item_id = response_1.data['id']
        assert response_1.data['quantity'] == 1
        
        # Add same accessory again
        data['quantity'] = 2
        response_2 = api_client.post(url, data, format='json')
        assert response_2.status_code == status.HTTP_201_CREATED
        second_item_id = response_2.data['id']
        
        # Should be the same item with incremented quantity
        assert first_item_id == second_item_id
        assert response_2.data['quantity'] == 3  # 1 + 2
        assert response_2.data['total_price'] == f"{accessory.price * 3:.2f}"
        
        # Verify only one BasketItem exists
        assert BasketItem.objects.filter(basket=basket).count() == 1
    
    def test_add_different_products_creates_separate_items(self, api_client, user, product, supply, basket):
        """Adding different products should create separate basket items"""
        api_client.force_authenticate(user=user)
        url = reverse('basket:basket_add')
        
        # Create another product and supply with unique SKU
        product_2 = Product.objects.create(name='Test Product 2', sku='sku-test-product-2')
        supply_2 = Supply.objects.create(product=product_2, price=75.00, quantity=20)
        
        # Add first product
        data_1 = {
            'product_id': product.id,
            'supply_id': supply.id,
            'quantity': 2
        }
        response_1 = api_client.post(url, data_1, format='json')
        assert response_1.status_code == status.HTTP_201_CREATED
        assert response_1.data['product_id'] == product.id
        
        # Add second product
        data_2 = {
            'product_id': product_2.id,
            'supply_id': supply_2.id,
            'quantity': 3
        }
        response_2 = api_client.post(url, data_2, format='json')
        assert response_2.status_code == status.HTTP_201_CREATED
        assert response_2.data['product_id'] == product_2.id
        
        # Different product IDs in responses
        assert response_1.data['id'] != response_2.data['id']
        
        # Verify two separate BasketItems exist
        assert BasketItem.objects.filter(basket=basket).count() == 2


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