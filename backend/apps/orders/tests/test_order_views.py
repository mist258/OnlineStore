import datetime
from decimal import Decimal
from unittest.mock import patch

from django.urls import reverse
from django.utils import timezone

from rest_framework import status

from apps.basket.models import Basket, BasketItem
from apps.discount_codes.models import DiscountCode
from apps.orders.models import Order, OrderPosition
from apps.products.models import Product
from apps.supplies.models import Supply
from apps.users.models import UserModel, UserProfileModel

import pytest
import pytz


@pytest.mark.django_db
class TestCreateOrderView:
    def test_create_order_product_authenticated(self, api_client, user, basket, product, supply, discount_code):
        api_client.force_authenticate(user=user)
        # Add item to basket
        supply_quantity_before = supply.quantity
        BasketItem.objects.create(
            basket=basket,
            product=product,
            quantity=2,
            supply=supply
        )

        url = reverse("orders:create_order")

        data = {
            "billing_details": {
                "first_name": "John",
                "last_name": "Doe",
                "country": "US",
                "phone_number": "+380985755044"
            },
            "discount_code": "SAVE50"
        }

        response = api_client.post(url, data, format="json")
        # ─── Assertions ──────────────────────────────────────────────
        assert response.status_code == status.HTTP_201_CREATED
        # Order created
        order = Order.objects.get(id=response.data["id"])

        # Customer snapshot or user reference
        assert order.customer.email == user.email

        # Billing details saved on order
        assert order.first_name == "John"
        assert order.last_name == "Doe"
        assert order.country == "US"
        assert order.phone_number == "+380985755044"
        assert order.discount_code.code == "SAVE50"
        
        # Positions created from basket
        assert order.positions.count() == 1
        position = order.positions.first()
        assert position.product == product
        assert position.quantity == 2
        supply.refresh_from_db()
        assert supply.quantity == supply_quantity_before - 2
        assert basket.items.count() == 0

        # Response payload
        assert len(response.data["positions"]) == 1

    def test_create_order_accessory_authenticated(self, api_client, user, basket, accessory):
            api_client.force_authenticate(user=user)
            # Add item to basket
            supply_quantity_before = accessory.quantity
            BasketItem.objects.create(
                basket=basket,
                accessory=accessory,
                quantity=2,
            )

            url = reverse("orders:create_order")

            data = {
                "billing_details": {
                    "first_name": "John",
                    "last_name": "Doe",
                    "country": "US",
                    "phone_number": "+380985755044"
                }
            }

            response = api_client.post(url, data, format="json")
            # ─── Assertions ──────────────────────────────────────────────
            assert response.status_code == status.HTTP_201_CREATED
            # Order created
            order = Order.objects.get(id=response.data["id"])

            # Customer snapshot or user reference
            assert order.customer.email == user.email

            # Billing details saved on order
            assert order.first_name == "John"
            assert order.last_name == "Doe"
            assert order.country == "US"
            assert order.phone_number == "+380985755044"
            
            # Positions created from basket
            assert order.positions.count() == 1
            position = order.positions.first()
            assert position.accessory == accessory
            assert position.quantity == 2
            accessory.refresh_from_db()
            assert accessory.quantity == supply_quantity_before - 2
            assert basket.items.count() == 0

            # Response payload
            assert len(response.data["positions"]) == 1
            
    def test_create_order_insufficient_stock(self, api_client, user, basket, product, supply):
        """Test that creating order with insufficient stock returns 400 Bad Request."""
        api_client.force_authenticate(user=user)
        
        # Set supply quantity to 1
        supply.quantity = 1
        supply.save()
        
        # Add item to basket with quantity 2 (more than available)
        BasketItem.objects.create(
            basket=basket,
            product=product,
            quantity=2,
            supply=supply
        )

        url = reverse("orders:create_order")
        data = {
            "billing_details": {
                "first_name": "John",
                "last_name": "Doe",
                "country": "US",
                "phone_number": "+380985755044"
            }
        }

        response = api_client.post(url, data, format="json")
        
        # Should return 400 Bad Request, not 500 Server Error
        assert response.status_code == status.HTTP_400_BAD_REQUEST
        assert "Not enough stock" in str(response.data)

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
    def test_update_order_status(self, api_client, admin_user, order):
        api_client.force_authenticate(user=admin_user)
        url = reverse('orders:update_order', kwargs={'pk': order.id})

        data = {
            'status': 'delivered'
        }

        response = api_client.patch(url, data, format='json')

        assert response.status_code == status.HTTP_200_OK
        assert response.data['status'] == 'delivered'


    def test_update_order_notes(self, api_client, admin_user, order):
        api_client.force_authenticate(user=admin_user)
        url = reverse('orders:update_order', kwargs={'pk': order.id})
        
        data = {
            'order_notes': 'Please deliver after 6 PM'
        }
        
        response = api_client.patch(url, data, format='json')
        
        assert response.status_code == status.HTTP_200_OK
        assert response.data['order_notes'] == 'Please deliver after 6 PM'

    def test_update_order_billing_details(self, api_client, admin_user, order):
        api_client.force_authenticate(user=admin_user)
        url = reverse('orders:update_order', kwargs={'pk': order.id})
        
        data = {
            "billing_details": {
                "first_name": "Alice",
                "last_name": "Smith",
                "country": "UK",
                "phone_number": "+441234567890"
            }
        }
        
        response = api_client.patch(url, data, format='json')
        print(f"@@@@@@@@@@ response.data: {response.data}")
        assert response.status_code == status.HTTP_200_OK
        assert response.data['first_name'] == 'Alice'
        assert response.data['last_name'] == 'Smith'
        assert response.data['country'] == 'UK'
        assert response.data['phone_number'] == '+441234567890'    
    

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

    def test_create_order_with_nonexistent_discount_code(self, api_client, user, basket, product, supply):
        """Test that order creation fails with non-existent discount code"""
        api_client.force_authenticate(user=user)
        BasketItem.objects.create(basket=basket, product=product, supply=supply, quantity=2)
        
        url = reverse('orders:create_order')
        data = {
            'billing_details': {
                'first_name': 'John',
                'last_name': 'Doe',
                'country': 'US',
                'phone_number': '+380991234567'
            },
            'discount_code': 'NONEXISTENT'
        }
        
        response = api_client.post(url, data, format='json')
        
        assert response.status_code == status.HTTP_400_BAD_REQUEST

    def test_create_order_with_inactive_discount_code(self, api_client, user, basket, product, supply):
        """Test that order creation fails with inactive discount code"""
        api_client.force_authenticate(user=user)
        BasketItem.objects.create(basket=basket, product=product, supply=supply, quantity=2)
        
        # Create inactive discount code
        inactive_code = DiscountCode.objects.create(
            code="INACTIVE20",
            discount_percent=20,
            active=False,
            valid_from=datetime.datetime(2023, 1, 1, 0, 0, 0, tzinfo=pytz.UTC),
            valid_to=datetime.datetime(2028, 12, 31, 23, 59, 59, tzinfo=pytz.UTC)
        )
        
        url = reverse('orders:create_order')
        data = {
            'billing_details': {
                'first_name': 'John',
                'last_name': 'Doe',
                'country': 'US',
                'phone_number': '+380991234567'
            },
            'discount_code': 'INACTIVE20'
        }
        
        response = api_client.post(url, data, format='json')
        
        # Should fail because discount code is inactive
        assert response.status_code == status.HTTP_400_BAD_REQUEST

    def test_create_order_with_expired_discount_code(self, api_client, user, basket, product, supply):
        """Test that order creation fails with expired discount code"""
        api_client.force_authenticate(user=user)
        BasketItem.objects.create(basket=basket, product=product, supply=supply, quantity=2)
        
        # Create expired discount code
        expired_code = DiscountCode.objects.create(
            code="EXPIRED20",
            discount_percent=20,
            active=True,
            valid_from=datetime.datetime(2020, 1, 1, 0, 0, 0, tzinfo=pytz.UTC),
            valid_to=datetime.datetime(2021, 12, 31, 23, 59, 59, tzinfo=pytz.UTC)
        )
        
        url = reverse('orders:create_order')
        data = {
            'billing_details': {
                'first_name': 'John',
                'last_name': 'Doe',
                'country': 'US',
                'phone_number': '+380991234567'
            },
            'discount_code': 'EXPIRED20'
        }
        
        response = api_client.post(url, data, format='json')
        
        # Should fail because discount code is expired
        assert response.status_code == status.HTTP_400_BAD_REQUEST

    def test_create_order_with_future_discount_code(self, api_client, user, basket, product, supply):
        """Test that order creation fails with not-yet-valid discount code"""
        api_client.force_authenticate(user=user)
        BasketItem.objects.create(basket=basket, product=product, supply=supply, quantity=2)
        
        # Create future discount code
        future_code = DiscountCode.objects.create(
            code="FUTURE20",
            discount_percent=20,
            active=True,
            valid_from=datetime.datetime(2030, 1, 1, 0, 0, 0, tzinfo=pytz.UTC),
            valid_to=datetime.datetime(2031, 12, 31, 23, 59, 59, tzinfo=pytz.UTC)
        )
        
        url = reverse('orders:create_order')
        data = {
            'billing_details': {
                'first_name': 'John',
                'last_name': 'Doe',
                'country': 'US',
                'phone_number': '+380991234567'
            },
            'discount_code': 'FUTURE20'
        }
        
        response = api_client.post(url, data, format='json')
        
        # Should fail because discount code is not yet valid
        assert response.status_code == status.HTTP_400_BAD_REQUEST

    def test_create_order_with_valid_discount_code(self, api_client, user, basket, product, supply):
        """Test that order creation succeeds with valid discount code"""
        api_client.force_authenticate(user=user)
        BasketItem.objects.create(basket=basket, product=product, supply=supply, quantity=2)
        
        # Create valid discount code
        now = timezone.now()
        valid_code = DiscountCode.objects.create(
            code="VALID20",
            discount_percent=20,
            active=True,
            valid_from=now - datetime.timedelta(days=10),
            valid_to=now + datetime.timedelta(days=10)
        )
        
        url = reverse('orders:create_order')
        data = {
            'billing_details': {
                'first_name': 'John',
                'last_name': 'Doe',
                'country': 'US',
                'phone_number': '+380991234567'
            },
            'discount_code': 'VALID20'
        }
        
        response = api_client.post(url, data, format='json')
        
        # Should succeed with valid discount code
        assert response.status_code == status.HTTP_201_CREATED
        order = Order.objects.get(id=response.data['id'])
        assert order.discount_code.code == 'VALID20'


@pytest.mark.django_db
class TestDeleteOrderView:
    def test_delete_order_as_admin(self, api_client, admin_user, order):
        api_client.force_authenticate(user=admin_user)
        url = reverse('orders:delete_order', kwargs={'pk': order.id})
        
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_204_NO_CONTENT
        assert not Order.objects.filter(id=order.id).exists()

    def test_delete_order_as_regular_user(self, api_client, user, order):
        api_client.force_authenticate(user=user)
        url = reverse('orders:delete_order', kwargs={'pk': order.id})
        
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_403_FORBIDDEN
        assert Order.objects.filter(id=order.id).exists()

    def test_delete_nonexistent_order(self, api_client, admin_user):
        api_client.force_authenticate(user=admin_user)
        url = reverse('orders:delete_order', kwargs={'pk': 99999})
        
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND

    def test_delete_order_unauthenticated(self, api_client, order):
        url = reverse('orders:delete_order', kwargs={'pk': order.id})
        
        response = api_client.delete(url)
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED
        assert Order.objects.filter(id=order.id).exists()


@pytest.mark.django_db
class TestListUserOrdersView:
    """
    Test suite for the ListUserOrdersView endpoint that retrieves only user's orders.
    """
    
    def test_list_user_orders_authenticated_user(self, api_client, user, order):
        """Test that authenticated user can list their own orders."""
        api_client.force_authenticate(user=user)
        url = reverse('orders:user_orders')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert len(response.data['data']) == 1
        assert response.data['data'][0]['id'] == order.id
        assert response.data['data'][0]['customer'] == user.id
    
    def test_list_user_orders_returns_only_user_orders(self, api_client, user, other_user):
        """Test that user only sees their own orders, not other users' orders."""
        # Create orders for both users
        user_order = Order.objects.create(customer=user)
        other_user_order = Order.objects.create(customer=other_user)
        
        api_client.force_authenticate(user=user)
        url = reverse('orders:user_orders')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert len(response.data['data']) == 1
        assert response.data['data'][0]['id'] == user_order.id
        assert response.data['data'][0]['customer'] == user.id
        
        # Verify other user's order is not included
        order_ids = [order['id'] for order in response.data['data']]
        assert other_user_order.id not in order_ids
    
    def test_list_user_orders_multiple_orders(self, api_client, user):
        """Test that user can see all of their multiple orders."""
        order1 = Order.objects.create(customer=user, status='pending')
        order2 = Order.objects.create(customer=user, status='processing')
        order3 = Order.objects.create(customer=user, status='shipped')
        
        api_client.force_authenticate(user=user)
        url = reverse('orders:user_orders')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert len(response.data['data']) == 3
        
        order_ids = [order['id'] for order in response.data['data']]
        assert order1.id in order_ids
        assert order2.id in order_ids
        assert order3.id in order_ids
    
    def test_list_user_orders_empty_list(self, api_client, user):
        """Test that user with no orders gets an empty list."""
        api_client.force_authenticate(user=user)
        url = reverse('orders:user_orders')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert len(response.data['data']) == 0
    
    def test_list_user_orders_unauthenticated(self, api_client):
        """Test that unauthenticated users cannot access the endpoint."""
        url = reverse('orders:user_orders')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED
    
    def test_list_user_orders_response_structure(self, api_client, user, order):
        """Test that the response contains correct order data."""
        api_client.force_authenticate(user=user)
        url = reverse('orders:user_orders')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert 'data' in response.data
        assert 'current_page' in response.data
        assert 'total_items' in response.data
        assert 'total_pages' in response.data
        
        order_data = response.data['data'][0]
        assert 'id' in order_data
        assert 'customer' in order_data
        assert 'status' in order_data


@pytest.mark.django_db
class TestOrderAmountInApiResponse:
    """
    Test suite for order_amount field in API responses.
    Verifies that get_order_amount() is correctly returned via serializer.
    """
    
    def test_order_amount_included_in_list_user_orders(self, api_client, user, product, supply):
        """Test that order_amount is included in list user orders response."""
        from decimal import Decimal
        
        order = Order.objects.create(customer=user)
        # supply.price = 100.0, quantity = 2, so total = 200
        OrderPosition.objects.create(
            order=order,
            product=product,
            quantity=2,
            price=supply.price
        )
        
        api_client.force_authenticate(user=user)
        url = reverse('orders:user_orders')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        order_data = response.data['data'][0]
        assert 'order_amount' in order_data
        assert order_data['order_amount'] == 200.0 or order_data['order_amount'] == Decimal('200.00')
    
    def test_order_amount_in_details_view(self, api_client, user, product, supply):
        """Test that order_amount is returned in order details view."""
        from decimal import Decimal
        
        order = Order.objects.create(customer=user)
        # supply.price = 100.0, quantity = 1, so total = 100
        OrderPosition.objects.create(
            order=order,
            product=product,
            quantity=1,
            price=supply.price
        )
        
        api_client.force_authenticate(user=user)
        url = reverse('orders:details_order', kwargs={'pk': order.id})
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert 'order_amount' in response.data
        assert response.data['order_amount'] == 100.0 or response.data['order_amount'] == Decimal('100.00')
    
    def test_order_amount_with_discount_in_api(self, api_client, user, product, supply, discount_code):
        """Test that order_amount correctly reflects discount in API response."""
        from decimal import Decimal
        
        order = Order.objects.create(customer=user, discount_code=discount_code)
        # supply.price = 100.0, quantity = 1, so total = 100
        OrderPosition.objects.create(
            order=order,
            product=product,
            quantity=1,
            price=supply.price
        )
        
        api_client.force_authenticate(user=user)
        url = reverse('orders:user_orders')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        order_data = response.data['data'][0]
        assert 'order_amount' in order_data
        # With 50% discount: 100 * 0.5 = 50
        # The amount might be float or Decimal depending on calculation
        order_amount = order_data['order_amount']
        assert abs(float(order_amount) - 50.0) < 0.01
    
    def test_order_amount_multiple_positions_in_api(self, api_client, user, product, supply):
        """Test order_amount calculation with multiple positions in API."""
        from decimal import Decimal
        
        order = Order.objects.create(customer=user)
        
        # supply.price = 100.0
        # position 1: 100 * 2 = 200
        # position 2: 100 * 1 = 100
        # total = 300
        OrderPosition.objects.create(
            order=order,
            product=product,
            quantity=2,
            price=supply.price
        )
        OrderPosition.objects.create(
            order=order,
            product=product,
            quantity=1,
            price=supply.price
        )
        
        api_client.force_authenticate(user=user)
        url = reverse('orders:user_orders')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        order_data = response.data['data'][0]
        assert 'order_amount' in order_data
        # Total: 200 + 100 = 300
        assert order_data['order_amount'] == 300.0 or order_data['order_amount'] == Decimal('300.00')
    
    def test_order_amount_empty_order_in_api(self, api_client, user):
        """Test that order_amount is 0 for order with no positions."""
        order = Order.objects.create(customer=user)
        
        api_client.force_authenticate(user=user)
        url = reverse('orders:user_orders')
        
        response = api_client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        order_data = response.data['data'][0]
        assert 'order_amount' in order_data
        assert order_data['order_amount'] == 0 or order_data['order_amount'] == Decimal('0')
    
    def test_order_amount_in_create_order_response(self, api_client, user, basket, product, supply):
        """Test that order_amount is included in create order response."""
        api_client.force_authenticate(user=user)
        
        # Add item to basket
        BasketItem.objects.create(
            basket=basket,
            product=product,
            quantity=2,
            supply=supply
        )
        
        url = reverse("orders:create_order")
        
        data = {
            "billing_details": {
                "first_name": "John",
                "last_name": "Doe",
                "country": "US",
                "phone_number": "+380985755044"
            }
        }
        
        response = api_client.post(url, data, format="json")
        
        assert response.status_code == status.HTTP_201_CREATED
        assert 'order_amount' in response.data
        # Verify order_amount is a valid number
        from decimal import Decimal
        assert isinstance(response.data['order_amount'], (int, float)) or isinstance(response.data['order_amount'], Decimal)