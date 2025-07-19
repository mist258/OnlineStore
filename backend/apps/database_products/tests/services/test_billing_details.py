import pytest
from apps.database_products.models import BillingDetails, Customer, Order
from apps.database_products.services.billing_details_service import (
    create_billing_details,
    get_billing_details_by_id,
    update_billing_details,
    delete_billing_details
)


@pytest.mark.django_db
def test_create_billing_details():
    customer = Customer.objects.create(email="testuser@example.com")
    order = Order.objects.create(customer=customer)

    data = {
        "first_name": "John",
        "last_name": "Doe",
        "company_name": "Acme Inc",
        "province": "Ontario",
        "city": "Toronto",
        "address_1": "123 Main St",
        "address_2": "Suite 4",
        "zip_code": "M5J2N8",
        "phone": "+1234567890",
        "is_configuration": True,
        "order_id": order.id,
        "customer_id": customer.id,
    }

    billing = create_billing_details(data)

    assert billing.first_name == "John"
    assert billing.last_name == "Doe"
    assert billing.company_name == "Acme Inc"
    assert billing.province == "Ontario"
    assert billing.city == "Toronto"
    assert billing.address_1 == "123 Main St"
    assert billing.address_2 == "Suite 4"
    assert billing.zip_code == "M5J2N8"
    assert billing.phone == "+1234567890"
    assert billing.is_configuration is True
    assert billing.order == order
    assert billing.customer == customer


@pytest.mark.django_db
def test_get_billing_details_by_id():
    customer = Customer.objects.create(email="gettest@example.com")
    order = Order.objects.create(customer=customer)
    billing = BillingDetails.objects.create(
        first_name="Jane",
        last_name="Smith",
        province="Quebec",
        city="Montreal",
        zip_code="H2X1Y4",
        phone="+1987654321",
        order=order,
        customer=customer
    )

    found = get_billing_details_by_id(billing.id)

    assert found.id == billing.id
    assert found.first_name == "Jane"
    assert found.customer == customer
    assert found.order == order


@pytest.mark.django_db
def test_update_billing_details():
    customer = Customer.objects.create(email="updatetest@example.com")
    order = Order.objects.create(customer=customer)
    billing = BillingDetails.objects.create(
        first_name="OldFirst",
        last_name="OldLast",
        province="Alberta",
        city="Calgary",
        zip_code="T2P1J9",
        phone="+1123456789",
        order=order,
        customer=customer
    )

    update_data = {
        "first_name": "NewFirst",
        "last_name": "NewLast",
        "city": "Edmonton",
        "phone": "+1098765432"
    }

    updated = update_billing_details(billing.id, update_data)

    assert updated.first_name == "NewFirst"
    assert updated.last_name == "NewLast"
    assert updated.city == "Edmonton"
    assert updated.phone == "+1098765432"


@pytest.mark.django_db
def test_delete_billing_details():
    customer = Customer.objects.create(email="deletetest@example.com")
    order = Order.objects.create(customer=customer)
    billing = BillingDetails.objects.create(
        first_name="Delete",
        last_name="Me",
        province="British Columbia",
        city="Vancouver",
        zip_code="V5K0A1",
        phone="+1012345678",
        order=order,
        customer=customer
    )

    delete_billing_details(billing.id)

    assert not BillingDetails.objects.filter(id=billing.id).exists()
