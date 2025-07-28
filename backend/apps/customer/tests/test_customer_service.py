import pytest

from apps.customer.models import Customer
from apps.customer.services.customer_service import (
    create_customer,
    delete_customer,
    get_customer_by_id,
    update_customer
)
from apps.subscription.models import Subscription


@pytest.mark.django_db
def test_create_customer():
    sub1 = Subscription.objects.create(name="News", letter="N")
    sub2 = Subscription.objects.create(name="Offers", letter="O")

    data = {
        "email": "user@example.com",
        "password": "securepassword",
        "is_guest": False,
        "subscription_ids": [sub1.id, sub2.id]
    }
    customer = create_customer(data)

    assert customer.email == "user@example.com"
    assert customer.password == "securepassword"
    assert customer.is_guest is False
    assert set(customer.subscriptions.all()) == {sub1, sub2}


@pytest.mark.django_db
def test_get_customer_by_id():
    customer = Customer.objects.create(email="test@example.com")
    found = get_customer_by_id(customer.id)

    assert found.id == customer.id
    assert found.email == "test@example.com"


@pytest.mark.django_db
def test_update_customer():
    sub1 = Subscription.objects.create(name="Monthly", letter="M")
    sub2 = Subscription.objects.create(name="Weekly", letter="W")
    customer = Customer.objects.create(
        email="old@example.com", 
        password="oldpass", 
        is_guest=True
    )
    customer.subscriptions.add(sub1)

    update_data = {
        "email": "new@example.com",
        "password": "newpass",
        "is_guest": False,
        "subscription_ids": [sub2.id]
    }
    updated = update_customer(customer.id, update_data)

    assert updated.email == "new@example.com"
    assert updated.password == "newpass"
    assert updated.is_guest is False
    assert list(updated.subscriptions.all()) == [sub2]


@pytest.mark.django_db
def test_delete_customer():
    customer = Customer.objects.create(email="delete@example.com")
    delete_customer(customer.id)

    assert not Customer.objects.filter(id=customer.id).exists()
