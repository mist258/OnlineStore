import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient
from apps.users.models import UserModel, UserProfileModel
from apps.orders.models import Order, OrderPosition
from apps.products.models import Product
from apps.supplies.models import Supply
from apps.basket.models import Basket, BasketItem
import uuid


@pytest.fixture
def uuid_token():
    return str(uuid.uuid4())


@pytest.fixture
def api_client():
    return APIClient()


@pytest.fixture
def admin_user(db):
    return UserModel.objects.create_superuser(
        email="admin@example.com",
        password="adminpass123",
        is_staff=True,
        is_superuser=True
    )


@pytest.fixture
def user():
    return UserModel.objects.create_user(
        email='test@example.com',
        password='testpass123'
    )

@pytest.fixture
def user_profile(user):
    return UserProfileModel.objects.create(
        user=user,
        first_name='John',
        last_name='Doe',
        country='US',
        phone_number='+1234567890'
    )

@pytest.fixture
def product():
    product = Product.objects.create(name='Test Product')
    return product


@pytest.fixture
def basket(user):
    return Basket.objects.create(user=user)


@pytest.fixture
def order(user, user_profile):
    return Order.objects.create(
        customer=user,
        billing_details=user_profile
    )


@pytest.fixture
def order_position(product, order):
    return OrderPosition.objects.create(
        order=order,
        product=product,
        quantity=2
    )
    
    
@pytest.fixture
def supply(product):
    return Supply.objects.create(product=product, price=100.0, quantity=10)


@pytest.mark.django_db
class TestCreateOrderView:
    def test_create_order_authenticated(self, api_client, user, basket, product, supply):
        api_client.force_authenticate(user=user)
        BasketItem.objects.create(basket=basket, product=product, quantity=2, supply=supply)
        
        url = reverse('orders:create_order')
        data = {
            'basket_id': basket.id,
            'customer_data': {
                'email': user.email
            },
            'billing_details': {
                'first_name': 'John',
                'last_name': 'Doe',
                'country': 'US',
                'phone_number': '+1234567890'
            }
        }
        
        response = api_client.post(url, data, format='json')

        assert response.status_code == status.HTTP_201_CREATED
        assert response.data['customer'] == user.id
        assert len(response.data['positions']) == 1


@pytest.mark.django_db
class TestOrderDetailView:
    def test_get_order_detail(self, api_client, user, order):
        api_client.force_authenticate(user=user)
        url = reverse('orders:details_order', kwargs={'pk': order.id})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['id'] == order.id
        assert response.data['customer'] == user.id

    def test_get_nonexistent_order(self, api_client, user):
        api_client.force_authenticate(user=user)
        url = reverse('orders:details_order', kwargs={'pk': 99999})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND


@pytest.mark.django_db
class TestUpdateOrderView:
    def test_update_order_status(self, api_client, admin_user, order):
        api_client.force_authenticate(user=admin_user)
        url = reverse('orders:update_order', kwargs={'pk': order.id})
        
        data = {
            'status': 'delivered'
        }
        
        response = api_client.patch(url, data, format='json')  # Add format='json'
        print(f'Response data: {response.data}')
        print(f'Response status: {response.status_code}')  # Add this for debugging
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['status'] == 'delivered'

    def test_update_order_notes(self, api_client, admin_user, order):
        api_client.force_authenticate(user=admin_user)
        url = reverse('orders:update_order', kwargs={'pk': order.id})
        
        data = {
            'order_notes': 'Please deliver after 6 PM'
        }
        
        response = api_client.patch(url, data)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['order_notes'] == 'Please deliver after 6 PM'


@pytest.mark.django_db
class TestOrderPermissions:
    def test_guest_cannot_access_orders(self, api_client):
        url = reverse('orders:order_list')
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED

    def test_user_can_only_access_own_orders(self, api_client, user, order):
        other_user = UserModel.objects.create_user(
            email='other@example.com',
            password='otherpass123'
        )
        api_client.force_authenticate(user=other_user)
        
        url = reverse('orders:order_detail', kwargs={'pk': order.id})
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND


@pytest.mark.django_db
class TestOrderValidation:
    def test_create_order_without_basket(self, api_client, user):
        api_client.force_authenticate(user=user)
        url = reverse('orders:create_order')
        
        data = {
            'billing_details': {
                'first_name': 'John',
                'last_name': 'Doe',
                'country': 'US',
                'phone_number': '+1234567890'
            }
        }
        
        response = api_client.post(url, data, format='json')
        
        assert response.status_code == status.HTTP_400_BAD_REQUEST
        assert 'basket_id' in response.data

    def test_create_order_with_empty_basket(self, api_client, user, basket):
        api_client.force_authenticate(user=user)
        url = reverse('orders:create_order')
        
        data = {
            'basket_id': basket.id,
            'billing_details': {
                'first_name': 'John',
                'last_name': 'Doe',
                'country': 'US',
                'phone_number': '+1234567890'
            }
        }
        
        response = api_client.post(url, data, format='json')
        
        assert response.status_code == status.HTTP_400_BAD_REQUEST
        assert 'basket' in response.data