import pytest
from decimal import Decimal
from unittest.mock import patch
from django.urls import reverse
from rest_framework import status
from apps.basket.models import BasketItem
from apps.orders.models import Order

@pytest.mark.django_db
class TestOrderCurrency:
    @patch('core.services.convert_currency_service.CurrencyService.get_exchange_rates')
    def test_create_order_with_uah_currency(self, mock_rates, api_client, user, basket, product, supply):
        # 1. Setup mock rates: 1 USD = 40 UAH
        mock_rates.return_value = {'USD': Decimal('40.00'), 'EUR': Decimal('42.00')}
        
        api_client.force_authenticate(user=user)
        
        # 2. Add item to basket. Product price is from supply.
        # Let's set supply price to 10 USD
        supply.price = Decimal('10.00')
        supply.save()
        
        BasketItem.objects.create(
            basket=basket,
            product=product,
            quantity=2, # 10 * 2 = 20 USD
            supply=supply
        )

        url = reverse("orders:create_order")
        data = {
            "billing_details": {
                "first_name": "John",
                "last_name": "Doe",
                "country": "Ukraine",
                "phone_number": "+380991122333"
            },
            "currency": "UAH"
        }

        # 3. Request creation in UAH
        response = api_client.post(url, data, format="json")
        
        # 4. Assertions
        assert response.status_code == status.HTTP_201_CREATED
        assert response.data["currency"] == "UAH"
        
        # 20 USD * 40 UAH/USD = 800 UAH
        # Check order amount from API response
        order_id = response.data["id"]
        
        # We need to make sure the serializer is used for the response
        # The test failed because it returned 20.00. 
        # This happens if the serializer in CreateOrderView doesn't use OrderReadSerializer for response
        # or if the currency conversion logic in OrderReadSerializer is not triggered.
        
        assert Decimal(response.data["order_amount"]) == Decimal('800.00')
        
        # Check database
        order = Order.objects.get(id=response.data["id"])
        assert order.currency == "UAH"

    @patch('core.services.convert_currency_service.CurrencyService.get_exchange_rates')
    def test_order_list_with_different_currencies(self, mock_rates, api_client, user, basket, product, supply):
        # Setup mock rates: 1 USD = 40 UAH, 1 EUR = 0.9 USD (approx, let's say 1 USD = 0.95 EUR)
        # Actually CurrencyService converts from USD to EUR via UAH: price_usd * usd_to_uah / eur_to_uah
        mock_rates.return_value = {'USD': Decimal('40.00'), 'EUR': Decimal('50.00')}
        
        api_client.force_authenticate(user=user)
        
        # Create an order in EUR. Price is 100 USD.
        order = Order.objects.create(
            customer=user,
            currency='EUR',
            first_name="Tester",
            last_name="EUR"
        )
        # Position with price 100 USD
        from apps.orders.models import OrderPosition
        OrderPosition.objects.create(
            order=order,
            product=product,
            price=Decimal('100.00'),
            quantity=1
        )
        
        # Expected amount in EUR: 100 * 40 / 50 = 80 EUR
    
        url = reverse("orders:user_orders")
        response = api_client.get(url)
        assert response.status_code == status.HTTP_200_OK
        # Find our order in response
        # The response structure might be OrderedDict, or the 'results' key might be missing if pagination is off
        results = response.data
        if isinstance(results, dict) and 'results' in results:
            results = results['results']

        import json
        # It's possible results is still a dictionary (OrderedDict) if not paginated and returning single object or something unexpected
        # But serializer (many=True) should return list.
        # If viewset uses pagination, it returns { count: ..., results: [...] }
        # Let's handle the case where results is a list of OrderedDicts
        
        # Debug print
        # print(f"DEBUG: Type of results: {type(results)}") 
        # print(f"DEBUG: Content: {results}")

        # The error "TypeError: string indices must be integers, not 'str'" suggests that 'results' might be iterating over keys of a dict?
        # If response.data is a dict (OrderedDict) and has NO 'results' key, then 'results' = response.data
        # Then iterating over 'results' iterates over KEYS (strings). So o is a string key. o['id'] fails.
        
        # So likely pagination is OFF or different structure.
        
        if isinstance(results, dict):
             # If it's a dict but not paginated structure we expect, maybe it's just one object? No, list endpoint returns list.
             # Maybe it IS paginated but we missed it?
             # Let's assume if it is a dict, we want values if it is an OrderedDict representing list? No.
             pass
        
        # Re-fetch logic
        if isinstance(response.data, list):
             results = response.data
        elif isinstance(response.data, dict):
             if 'results' in response.data:
                 results = response.data['results']
             elif 'data' in response.data:
                 results = response.data['data']
             else:
                 results = []
        else:
             results = []

        print(f"\nDEBUG: Response data type: {type(response.data)}")
        print(f"DEBUG: Response data: {response.data}")
        print(f"DEBUG: Order ID expected: {order.id}")
        
        # If results is empty, it might be due to pagination default config or something else.
        if not results:
             print("DEBUG: Results list is empty!")
        
        order_data = next(o for o in results if o['id'] == order.id)
        assert order_data['currency'] == 'EUR'
        assert Decimal(order_data['order_amount']) == Decimal('80.00')
