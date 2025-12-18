from django.urls import reverse

from rest_framework import status

import pytest


@pytest.mark.django_db
class TestDiscountCodeView:
    def test_get_valid_discount_code(self, api_client, discount_code):
        url = reverse('discount_codes:get_discount_code', kwargs={'code': discount_code.code})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['code'] == discount_code.code
        assert response.data['is_valid'] is True

    def test_get_invalid_discount_code(self, api_client):
        url = reverse('discount_codes:get_discount_code', kwargs={'code': 'INVALIDCODE'})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND
        
    def test_get_apply_discount_with_order(self, api_client, discount_code, order):
        url = reverse('discount_codes:get_discount_code_with_order', kwargs={'code': discount_code.code, 'order_id': order.id})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['code'] == discount_code.code
        assert response.data['is_valid'] is True
        assert response.data['appy_discount'] == discount_code.apply_discount(order.get_order_amount())
        
    def test_create_discount_code_unauthenticated(self, api_client):
        url = reverse('discount_codes:create_discount_code')
        
        data = {
            'code': 'NEWCODE',
            'description': 'New Discount Code',
            'discount_percent': 15,
            'valid_from': '2024-01-01T00:00:00Z',
            'valid_to': '2024-12-31T23:59:59Z',
            'active': True
        }
        
        response = api_client.post(url, data, format='json')
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED
        
    def test_create_discount_code_authenticated(self, api_client, admin_user):
        api_client.force_authenticate(user=admin_user)
        url = reverse('discount_codes:create_discount_code')

        data = {
            'code': 'NEWCODE',
            'description': 'New Discount Code',
            'discount_percent': '15.00',
            'valid_from': '2024-01-01T00:00:00Z',
            'valid_to': '2024-12-31T23:59:59Z',
            'active': True
        }
        response = api_client.post(url, data, format='json')
        print(f"Response data: {response.data}")

        assert response.status_code == status.HTTP_201_CREATED
        assert response.data['code'] == data['code']
        assert response.data['discount_percent'] == data['discount_percent']
