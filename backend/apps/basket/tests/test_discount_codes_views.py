import pytest
from django.urls import reverse
from rest_framework.test import APIClient
from rest_framework import status


@pytest.mark.django_db
class TestDiscountCodeView:
    def test_get_valid_discount_code(self, api_client, discount_code):
        url = reverse('basket:basket_discount', kwargs={'code': discount_code.code})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['code'] == discount_code.code
        assert response.data['is_valid'] is True

    def test_get_invalid_discount_code(self, api_client):
        url = reverse('basket:basket_discount', kwargs={'code': 'INVALIDCODE'})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND
        
    def test_get_apply_discount_with_order(self, api_client, discount_code, order):
        url = reverse('basket:basket_discount_with_order', kwargs={'code': discount_code.code, 'order_id': order.id})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['code'] == discount_code.code
        assert response.data['is_valid'] is True
        assert response.data['appy_discount'] == discount_code.apply_discount(order.get_order_amount())