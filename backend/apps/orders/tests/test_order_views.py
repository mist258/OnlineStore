import pytest
from django.urls import reverse
from unittest.mock import patch
from rest_framework import status
from apps.users.models import UserModel, UserProfileModel
from apps.orders.models import Order, OrderPosition
from apps.products.models import Product
from apps.supplies.models import Supply
from apps.basket.models import Basket, BasketItem


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
class TestOrderDetailsView:
    def test_get_order_details(self, api_client, user, order):
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
    @patch("apps.orders.models.EmailService.send_order_status_email", return_value=None)
    def test_update_order_status(self, mock_send_email, api_client, admin_user, order):
        api_client.force_authenticate(user=admin_user)
        url = reverse('orders:update_order', kwargs={'pk': order.id})

        data = {
            'status': 'delivered'
        }

        response = api_client.patch(url, data, format='json')

        print(f'Response data: {response.data}')
        print(f'Response status: {response.status_code}')

        assert response.status_code == status.HTTP_200_OK
        assert response.data['status'] == 'delivered'

        mock_send_email.assert_called_once_with(
            order_id=order.id,
            status="delivered",
            customer_email=order.customer.email,
            first_name=order.billing_details.first_name,
            last_name=order.billing_details.last_name,
        )

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
        url = reverse('orders:list_orders')
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED

    def test_user_can_only_access_own_orders(self, api_client, order, other_user):
        api_client.force_authenticate(user=other_user)
        
        url = reverse('orders:details_order', kwargs={'pk': order.id})
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