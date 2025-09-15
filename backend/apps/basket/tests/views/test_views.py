import pytest
from django.urls import reverse
from rest_framework.test import APIClient
from rest_framework import status
from apps.users.models import UserModel
from apps.basket.models import Basket, BasketItem
from apps.products.models import Product, Accessory
from apps.supplies.models import Supply


@pytest.fixture
def api_client():
    return APIClient()


@pytest.fixture
def user():
    return UserModel.objects.create_user(
        email='test@example.com',
        password='testpass123'
    )


@pytest.fixture
def product():
    product = Product.objects.create(name='Test Product')
    Supply.objects.create(product=product, price=100.0, quantity=10)
    return product


@pytest.fixture
def basket(user):
    return Basket.objects.create(user=user)


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
        assert 'guest_token' in response.data
        assert 'user' not in response.data


@pytest.mark.django_db
class TestAddBasketItemView:
    def test_add_item_authenticated(self, api_client, user, product):
        api_client.force_authenticate(user=user)
        url = reverse('basket:basket_add')
        
        data = {
            'product': product.id,
            'quantity': 2
        }
        
        response = api_client.post(url, data)
        
        assert response.status_code == status.HTTP_201_CREATED
        assert response.data['quantity'] == 2
        assert response.data['product'] == product.id

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
            product=product,
            quantity=1
        )
        
        url = reverse('basket:basket_update')
        data = {
            'id': basket_item.id,
            'quantity': 3
        }
        
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
        
        url = reverse('basket:basket_update')
        data = {'quantity': 2}
        
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
        
        data = {'pk': basket_item.id}

        url = reverse('basket:basket_delete', kwargs=data)
        response = api_client.delete(url, data)
        
        assert response.status_code == status.HTTP_204_NO_CONTENT
        assert not BasketItem.objects.filter(id=basket_item.id).exists()

    def test_delete_nonexistent_item(self, api_client, user):
        api_client.force_authenticate(user=user)
        data = {'pk': 99999}

        url = reverse('basket:basket_delete', kwargs=data)
        response = api_client.delete(url, data)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND


@pytest.mark.django_db
class TestBasketPermissions:
    def test_anonymous_user_can_create_basket(self, api_client):
        url = reverse('basket:basket_summary')
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert 'guest_token' in response.cookies

    def test_authenticated_user_cannot_access_other_user_basket(
        self, api_client, user, basket
    ):
        other_user = UserModel.objects.create_user(
            email='other@example.com',
            password='otherpass123'
        )
        api_client.force_authenticate(user=other_user)
        
        url = reverse('basket:basket_summary')
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['user'] == other_user.id
        assert response.data['user'] != user.id