from apps.users.models import UserModel, UserProfileModel
from apps.orders.models import Order
from apps.basket.models import Basket, BasketItem
from apps.products.models import Product, Accessory
from apps.supplies.models import Supply

import pytest

from backend.apps.orders.services.order_service import create_order, delete_order, get_order_by_id, update_order


@pytest.mark.django_db
def test_create_order():
    customer = UserModel.objects.create(email="alice@example.com")
    basket = Basket.objects.create(customer=customer)
    accessory = Accessory.objects.create(name="Headphones", price=100.0, quantity=10)
    product = Product.objects.create(name="Smartphone")
    supply = Supply.objects.create(product=product, price=500.0, quantity=5)
    basket_item = BasketItem.objects.create(
        basket=basket,
        accessory=accessory,
        product=product,
        supply=supply,
        quantity=2
    )
    billing_details = UserProfileModel.objects.create(
        user=customer,
        first_name="Alice",
        last_name="Smith",
        company_name="Wonderland Inc.",
        country="Fictionland",
        state="Imagination",
        region="Dreams",
        street_name="Main St",
        apartment_number="1A",
        zip_code="12345",
        phone_number="1234567890"
    )
    data = {
        "customer_id": customer.id,
        "billing_details_id": billing_details.id,
        "data": {
            "order_notes": "Leave at the front desk",
            "customer_data": {
                "email": "alice@example.com",
                "subscribtion_updates_news": True
            },
            "billing_details": {
                "first_name": "Alice",
                "last_name": "Smith",
                "company_name": "Wonderland Inc.",
                "country": "Fictionland",
                "state": "Imagination",
                "region": "Dreams",
                "street_name": "Main St",
                "apartment_number": "1A",
                "zip_code": "12345",
                "phone_number": "1234567890",
            },
            "basket": {
                "id": basket.id
            }
            
        }
        
    }

    order = create_order(data)

    assert order.customer.id == customer.id
    assert order.order_notes == "Leave at the front desk"
    assert order.billing_details == billing_details
    assert order.status == "processing"
    assert order.ttn is None
    assert order.billing_details.first_name == "Alice"
    assert order.billing_details.last_name == "Smith"
    assert order.billing_details.phone_number == "1234567890"


@pytest.mark.django_db
def test_get_order_by_id():
    customer = UserModel.objects.create(email="bob@example.com")
    billing_details = UserProfileModel.objects.create(
        user=customer,
        first_name="Alice",
        last_name="Smith",
        company_name="Wonderland Inc.",
        country="Fictionland",
        state="Imagination",
        region="Dreams",
        street_name="Main St",
        apartment_number="1A",
        zip_code="12345",
        phone_number="1234567890"
    )
    order = Order.objects.create(customer=customer, billing_details=billing_details, order_notes="Deliver after 5 PM")

    found = get_order_by_id(order.id)

    assert found.id == order.id
    assert found.customer == customer
    assert found.order_notes == "Deliver after 5 PM"
    assert order.billing_details == billing_details
    assert order.status == "processing"
    assert order.ttn is None
    assert order.billing_details.first_name == "Alice"
    assert order.billing_details.last_name == "Smith"
    assert order.billing_details.phone_number == "1234567890"


@pytest.mark.django_db
def test_update_order():
    customer = UserModel.objects.create(email="carol@example.com")
    billing_details = UserProfileModel.objects.create(
        user=customer,
        first_name="Alice",
        last_name="Smith",
        company_name="Wonderland Inc.",
        country="Fictionland",
        state="Imagination",
        region="Dreams",
        street_name="Main St",
        apartment_number="1A",
        zip_code="12345",
        phone_number="1234567890"
    )
    order = Order.objects.create(customer=customer, billing_details=billing_details, order_notes="Initial note")

    updated = update_order(order.id, {"order_notes": "Updated delivery instructions"})

    assert updated.order_notes == "Updated delivery instructions"


@pytest.mark.django_db
def test_delete_order():
    customer = UserModel.objects.create(email="dave@example.com")
    billing_details = UserProfileModel.objects.create(
        user=customer,
        first_name="Alice",
        last_name="Smith",
        company_name="Wonderland Inc.",
        country="Fictionland",
        state="Imagination",
        region="Dreams",
        street_name="Main St",
        apartment_number="1A",
        zip_code="12345",
        phone_number="1234567890"
    )
    order = Order.objects.create(customer=customer, billing_details=billing_details, order_notes="Handle with care")

    delete_order(order.id)

    assert not Order.objects.filter(id=order.id).exists()
