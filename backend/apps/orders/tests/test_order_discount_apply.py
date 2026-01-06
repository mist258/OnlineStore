"""
Tests for discount code apply_discount field in order responses.

These tests ensure that the apply_discount field correctly shows the discounted
amount when retrieving orders with discount codes.
"""
import datetime

from django.urls import reverse
from django.utils import timezone

from rest_framework import status

from apps.basket.models import BasketItem
from apps.discount_codes.models import DiscountCode
from apps.orders.models import Order, OrderPosition

import pytest
import pytz


@pytest.mark.django_db
class TestOrderDiscountCodeApplyDiscount:
    """Test apply_discount field in order responses"""

    def test_order_detail_shows_apply_discount_for_valid_code(
        self, api_client, user, order, product
    ):
        """Test that order detail shows correct apply_discount for valid discount code"""
        api_client.force_authenticate(user=user)
        
        # Create valid discount code (15% discount)
        now = timezone.now()
        valid_code = DiscountCode.objects.create(
            code="SAVE15",
            discount_percent=15,
            active=True,
            valid_from=now - datetime.timedelta(days=10),
            valid_to=now + datetime.timedelta(days=10)
        )
        
        # Add discount code to order
        order.discount_code = valid_code
        order.save()
        
        # Create order position (100 * 2 = 200)
        OrderPosition.objects.create(
            order=order,
            product=product,
            price=100,
            quantity=2
        )
        
        url = reverse('orders:details_order', kwargs={'pk': order.id})
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['discount_code'] is not None
        assert response.data['discount_code']['code'] == 'SAVE15'
        assert response.data['discount_code']['is_valid'] is True
        
        # Original amount: 200, 15% discount = 30 saved, final = 170
        assert float(response.data['discount_code']['apply_discount']) == 30.0  # Discount amount
        assert float(response.data['order_amount']) == 170.0  # Final price

    def test_order_detail_shows_apply_discount_for_invalid_code(
        self, api_client, user, order, product
    ):
        """Test that order detail shows actual applied discount even if code is now invalid/expired"""
        api_client.force_authenticate(user=user)
        
        # Create expired discount code
        expired_code = DiscountCode.objects.create(
            code="EXPIRED15",
            discount_percent=15,
            active=True,
            valid_from=datetime.datetime(2020, 1, 1, 0, 0, 0, tzinfo=pytz.UTC),
            valid_to=datetime.datetime(2021, 12, 31, 23, 59, 59, tzinfo=pytz.UTC)
        )
        
        # Add discount code to order
        order.discount_code = expired_code
        order.save()
        
        # Create order position (100 * 2 = 200)
        OrderPosition.objects.create(
            order=order,
            product=product,
            price=100,
            quantity=2
        )
        
        url = reverse('orders:details_order', kwargs={'pk': order.id})
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['discount_code'] is not None
        assert response.data['discount_code']['code'] == 'EXPIRED15'
        assert response.data['discount_code']['is_valid'] is False
        
        # Even though code is expired, apply_discount shows the historical discount that was applied
        # Original: 200, 15% discount = 30 saved, final = 170
        assert float(response.data['discount_code']['apply_discount']) == 30.0
        assert float(response.data['order_amount']) == 170.0

    def test_order_list_shows_apply_discount(
        self, api_client, user, order, product
    ):
        """Test that order list shows correct apply_discount"""
        api_client.force_authenticate(user=user)
        
        # Create valid discount code (20% discount)
        now = timezone.now()
        valid_code = DiscountCode.objects.create(
            code="SAVE20",
            discount_percent=20,
            active=True,
            valid_from=now - datetime.timedelta(days=10),
            valid_to=now + datetime.timedelta(days=10)
        )
        
        # Add discount code to order
        order.discount_code = valid_code
        order.save()
        
        # Create order position (50 * 3 = 150)
        OrderPosition.objects.create(
            order=order,
            product=product,
            price=50,
            quantity=3
        )
        
        url = reverse('orders:user_orders')
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        
        # Response is paginated
        orders_list = response.data.get("data", response.data)
        assert len(orders_list) > 0
        
        order_data = next((o for o in orders_list if o["id"] == order.id), None)
        assert order_data is not None
        assert order_data['discount_code'] is not None
        assert order_data['discount_code']['code'] == 'SAVE20'
        assert order_data['discount_code']['is_valid'] is True
        
        # Original: 150, 20% discount = 30 saved, final = 120
        assert float(order_data['discount_code']['apply_discount']) == 30.0  # Discount amount
        assert float(order_data['order_amount']) == 120.0  # Final price

    def test_order_without_discount_code(self, api_client, user, order, product):
        """Test that order without discount code shows None"""
        api_client.force_authenticate(user=user)
        
        # Create order position without discount code
        OrderPosition.objects.create(
            order=order,
            product=product,
            price=75,
            quantity=2
        )
        
        url = reverse('orders:details_order', kwargs={'pk': order.id})
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['discount_code'] is None
        assert float(response.data['order_amount']) == 150.0

    def test_multiple_positions_with_discount(
        self, api_client, user, order, product, accessory
    ):
        """Test apply_discount with multiple order positions"""
        api_client.force_authenticate(user=user)
        
        # Create valid discount code (25% discount)
        now = timezone.now()
        valid_code = DiscountCode.objects.create(
            code="SAVE25",
            discount_percent=25,
            active=True,
            valid_from=now - datetime.timedelta(days=10),
            valid_to=now + datetime.timedelta(days=10)
        )
        
        # Add discount code to order
        order.discount_code = valid_code
        order.save()
        
        # Create multiple positions (100*1 + 50*2 = 200)
        OrderPosition.objects.create(
            order=order,
            product=product,
            price=100,
            quantity=1
        )
        OrderPosition.objects.create(
            order=order,
            accessory=accessory,
            price=50,
            quantity=2
        )
        
        url = reverse('orders:details_order', kwargs={'pk': order.id})
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert len(response.data['positions']) == 2
        
        # Original: 200, 25% discount = 50 saved, final = 150
        assert float(response.data['discount_code']['apply_discount']) == 50.0  # Discount amount
        assert float(response.data['order_amount']) == 150.0  # Final price

    def test_inactive_discount_code_shows_no_discount(
        self, api_client, user, order, product
    ):
        """Test that inactive discount code shows actual applied discount from order creation"""
        api_client.force_authenticate(user=user)
        
        # Create inactive discount code
        now = timezone.now()
        inactive_code = DiscountCode.objects.create(
            code="INACTIVE30",
            discount_percent=30,
            active=False,  # Inactive
            valid_from=now - datetime.timedelta(days=10),
            valid_to=now + datetime.timedelta(days=10)
        )
        
        # Add discount code to order
        order.discount_code = inactive_code
        order.save()
        
        # Create order position (80 * 2 = 160)
        OrderPosition.objects.create(
            order=order,
            product=product,
            price=80,
            quantity=2
        )
        
        url = reverse('orders:details_order', kwargs={'pk': order.id})
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['discount_code'] is not None
        assert response.data['discount_code']['is_valid'] is False
        
        # Shows the historical applied discount (30% of 160 = 48)
        assert float(response.data['discount_code']['apply_discount']) == 48.0
        assert float(response.data['order_amount']) == 112.0

    def test_zero_percent_discount(self, api_client, user, order, product):
        """Test discount code with 0% discount"""
        api_client.force_authenticate(user=user)
        
        # Create valid code with 0% discount
        now = timezone.now()
        zero_code = DiscountCode.objects.create(
            code="ZERO",
            discount_percent=0,
            active=True,
            valid_from=now - datetime.timedelta(days=10),
            valid_to=now + datetime.timedelta(days=10)
        )
        
        order.discount_code = zero_code
        order.save()
        
        OrderPosition.objects.create(
            order=order,
            product=product,
            price=100,
            quantity=1
        )
        
        url = reverse('orders:details_order', kwargs={'pk': order.id})
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert float(response.data['discount_code']['apply_discount']) == 0.0  # 0% discount = $0 saved
        assert float(response.data['order_amount']) == 100.0  # Full price

    def test_hundred_percent_discount(self, api_client, user, order, product):
        """Test discount code with 100% discount"""
        api_client.force_authenticate(user=user)
        
        # Create valid code with 100% discount
        now = timezone.now()
        free_code = DiscountCode.objects.create(
            code="FREE100",
            discount_percent=100,
            active=True,
            valid_from=now - datetime.timedelta(days=10),
            valid_to=now + datetime.timedelta(days=10)
        )
        
        order.discount_code = free_code
        order.save()
        
        OrderPosition.objects.create(
            order=order,
            product=product,
            price=50,
            quantity=2
        )
        
        url = reverse('orders:details_order', kwargs={'pk': order.id})
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert float(response.data['discount_code']['apply_discount']) == 100.0  # Full discount
        assert float(response.data['order_amount']) == 0.0  # Free

    def test_real_world_scenario_expired_code(self, api_client, user, order, product):
        """Test real-world scenario: order created with valid code that later expired"""
        api_client.force_authenticate(user=user)
        
        # Create discount code that was valid in 2024 but expired
        expired_code = DiscountCode.objects.create(
            code="NEWCODE_1",
            discount_percent=15,
            active=True,
            valid_from=datetime.datetime(2024, 1, 1, 0, 0, 0, tzinfo=pytz.UTC),
            valid_to=datetime.datetime(2024, 12, 31, 23, 59, 59, tzinfo=pytz.UTC)
        )
        
        # Simulate order created in 2025 when code was still being used
        order.discount_code = expired_code
        order.created_at = datetime.datetime(2025, 12, 29, 22, 52, 10, tzinfo=pytz.UTC)
        order.save()
        
        # Create order position: 6 items at $15 = $90
        OrderPosition.objects.create(
            order=order,
            product=product,
            price=15,
            quantity=6
        )
        
        url = reverse('orders:details_order', kwargs={'pk': order.id})
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['discount_code'] is not None
        assert response.data['discount_code']['code'] == 'NEWCODE_1'
        assert response.data['discount_code']['is_valid'] is False  # Code is now expired
        
        # Original: 90, 15% discount = 13.5 saved, final = 76.5
        assert float(response.data['discount_code']['apply_discount']) == 13.5
        assert float(response.data['order_amount']) == 76.5
