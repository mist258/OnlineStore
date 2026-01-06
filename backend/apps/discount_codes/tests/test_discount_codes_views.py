import datetime

from django.urls import reverse
from django.utils import timezone

from rest_framework import status

from apps.discount_codes.models import DiscountCode

import pytest
import pytz


@pytest.mark.django_db
class TestDiscountCodeView:
    def test_get_valid_discount_code(self, api_client, discount_code):
        url = reverse('discount_codes:discount_code_detail', kwargs={'code': discount_code.code})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['code'] == discount_code.code
        assert response.data['is_valid'] is True

    def test_get_invalid_discount_code(self, api_client):
        url = reverse('discount_codes:discount_code_detail', kwargs={'code': 'INVALIDCODE'})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND
        
    def test_get_apply_discount_with_order(self, api_client, discount_code, order):
        url = reverse('discount_codes:get_discount_code_with_order', kwargs={'code': discount_code.code, 'order_id': order.id})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['code'] == discount_code.code
        assert response.data['is_valid'] is True
        assert response.data['appy_discount_sum'] == discount_code.apply_discount(order.get_order_amount())

    def test_create_discount_code_unauthenticated(self, api_client):
        url = reverse('discount_codes:create_discount_code')
        
        data = {
            "code": "NEWCODE",
            "description": "New Discount Code",
            "discount_percent": 15,
            "valid_from": "2024-01-01T00:00:00Z",
            "valid_to": "2024-12-31T23:59:59Z",
            "active": True
        }
        
        response = api_client.post(url, data, format='json')
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED
        
    def test_create_discount_code_authenticated(self, api_client, admin_user, user):
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

    def test_update_discount_code_unauthenticated(self, api_client, discount_code):
        url = reverse('discount_codes:discount_code_detail', kwargs={'code': discount_code.code})
        
        data = {
            'description': 'Updated Description',
            'discount_percent': 25
        }
        
        response = api_client.patch(url, data, format='json')
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED

    def test_update_discount_code_authenticated(self, api_client, admin_user, discount_code):
        api_client.force_authenticate(user=admin_user)
        url = reverse('discount_codes:discount_code_detail', kwargs={'code': discount_code.code})
        
        data = {
            'description': 'Updated Description',
            'discount_percent': '25.00'
        }
        
        response = api_client.patch(url, data, format='json')

        assert response.status_code == status.HTTP_200_OK
        assert response.data['description'] == data['description']
        assert response.data['discount_percent'] == data['discount_percent']

    def test_delete_discount_code_unauthenticated(self, api_client, discount_code):
        url = reverse('discount_codes:discount_code_detail', kwargs={'code': discount_code.code})
        
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED

    def test_delete_discount_code_authenticated(self, api_client, admin_user, discount_code):
        api_client.force_authenticate(user=admin_user)
        url = reverse('discount_codes:discount_code_detail', kwargs={'code': discount_code.code})
        
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
class TestDiscountCodeValidation:
    """Test discount code validation - active status and date range checks"""

    def test_inactive_discount_code_is_invalid(self, api_client):
        """Test that inactive discount codes are marked as invalid"""
        inactive_code = DiscountCode.objects.create(
            code="INACTIVE50",
            description="Inactive discount",
            discount_percent=50,
            active=False,
            valid_from=datetime.datetime(2023, 1, 1, 0, 0, 0, tzinfo=pytz.UTC),
            valid_to=datetime.datetime(2028, 12, 31, 23, 59, 59, tzinfo=pytz.UTC)
        )

        url = reverse('discount_codes:discount_code_detail', kwargs={'code': inactive_code.code})
        response = api_client.get(url)

        assert response.status_code == status.HTTP_200_OK
        assert response.data['code'] == inactive_code.code
        assert response.data['active'] is False
        assert response.data['is_valid'] is False

    def test_expired_discount_code_is_invalid(self, api_client):
        """Test that expired discount codes are marked as invalid"""
        expired_code = DiscountCode.objects.create(
            code="EXPIRED50",
            description="Expired discount",
            discount_percent=50,
            active=True,
            valid_from=datetime.datetime(2020, 1, 1, 0, 0, 0, tzinfo=pytz.UTC),
            valid_to=datetime.datetime(2021, 12, 31, 23, 59, 59, tzinfo=pytz.UTC)
        )

        url = reverse('discount_codes:discount_code_detail', kwargs={'code': expired_code.code})
        response = api_client.get(url)

        assert response.status_code == status.HTTP_200_OK
        assert response.data['code'] == expired_code.code
        assert response.data['active'] is True
        assert response.data['is_valid'] is False

    def test_not_yet_valid_discount_code_is_invalid(self, api_client):
        """Test that discount codes not yet valid are marked as invalid"""
        future_code = DiscountCode.objects.create(
            code="FUTURE50",
            description="Future discount",
            discount_percent=50,
            active=True,
            valid_from=datetime.datetime(2030, 1, 1, 0, 0, 0, tzinfo=pytz.UTC),
            valid_to=datetime.datetime(2031, 12, 31, 23, 59, 59, tzinfo=pytz.UTC)
        )

        url = reverse('discount_codes:discount_code_detail', kwargs={'code': future_code.code})
        response = api_client.get(url)

        assert response.status_code == status.HTTP_200_OK
        assert response.data['code'] == future_code.code
        assert response.data['active'] is True
        assert response.data['is_valid'] is False

    def test_valid_discount_code_within_date_range(self, api_client):
        """Test that active discount codes within valid date range are marked as valid"""
        now = timezone.now()
        valid_code = DiscountCode.objects.create(
            code="VALID50",
            description="Valid discount",
            discount_percent=50,
            active=True,
            valid_from=now - datetime.timedelta(days=10),
            valid_to=now + datetime.timedelta(days=10)
        )

        url = reverse('discount_codes:discount_code_detail', kwargs={'code': valid_code.code})
        response = api_client.get(url)

        assert response.status_code == status.HTTP_200_OK
        assert response.data['code'] == valid_code.code
        assert response.data['active'] is True
        assert response.data['is_valid'] is True

    def test_discount_code_apply_discount_only_if_valid(self):
        """Test that apply_discount only applies discount if code is valid"""
        # Valid code
        now = timezone.now()
        valid_code = DiscountCode.objects.create(
            code="VALID50",
            discount_percent=50,
            active=True,
            valid_from=now - datetime.timedelta(days=10),
            valid_to=now + datetime.timedelta(days=10)
        )
        assert valid_code.apply_discount(100) == 50

        # Invalid code (inactive)
        inactive_code = DiscountCode.objects.create(
            code="INACTIVE50",
            discount_percent=50,
            active=False,
            valid_from=now - datetime.timedelta(days=10),
            valid_to=now + datetime.timedelta(days=10)
        )
        assert inactive_code.apply_discount(100) == 100  # No discount applied

        # Invalid code (expired)
        expired_code = DiscountCode.objects.create(
            code="EXPIRED50",
            discount_percent=50,
            active=True,
            valid_from=datetime.datetime(2020, 1, 1, 0, 0, 0, tzinfo=pytz.UTC),
            valid_to=datetime.datetime(2021, 12, 31, 23, 59, 59, tzinfo=pytz.UTC)
        )
        assert expired_code.apply_discount(100) == 100  # No discount applied
