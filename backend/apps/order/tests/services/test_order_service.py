from apps.customer.models import Customer
from apps.order.models import Order

import pytest

from backend.apps.order.services.order_service import create_order, delete_order, get_order_by_id, update_order


@pytest.mark.django_db
def test_create_order():
    customer = Customer.objects.create(email="alice@example.com", is_guest=False)

    data = {
        "customer_id": customer.id,
        "order_notes": "Leave at the front desk"
    }

    order = create_order(data)

    assert order.customer.id == customer.id
    assert order.order_notes == "Leave at the front desk"


@pytest.mark.django_db
def test_get_order_by_id():
    customer = Customer.objects.create(email="bob@example.com")
    order = Order.objects.create(customer=customer, order_notes="Deliver after 5 PM")

    found = get_order_by_id(order.id)

    assert found.id == order.id
    assert found.customer == customer
    assert found.order_notes == "Deliver after 5 PM"


@pytest.mark.django_db
def test_update_order():
    customer = Customer.objects.create(email="carol@example.com")
    order = Order.objects.create(customer=customer, order_notes="Initial note")

    updated = update_order(order.id, {"order_notes": "Updated delivery instructions"})

    assert updated.order_notes == "Updated delivery instructions"


@pytest.mark.django_db
def test_delete_order():
    customer = Customer.objects.create(email="dave@example.com")
    order = Order.objects.create(customer=customer, order_notes="Handle with care")

    delete_order(order.id)

    assert not Order.objects.filter(id=order.id).exists()
