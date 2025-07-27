import pytest
from apps.database_products.models import Order, Product, Customer, OrderPosition
from backend.apps.order.services.order_position_service import (
    create_order_position,
    get_order_position_by_id,
    update_order_position,
    delete_order_position
)


@pytest.mark.django_db
def test_create_order_position():
    customer = Customer.objects.create(email="alice@example.com")
    product = Product.objects.create(name="Espresso", roast="Dark", caffeine_type="regular")
    order = Order.objects.create(customer=customer)

    data = {
        "quantity": 3,
        "product_id": product.id,
        "order_id": order.id
    }

    position = create_order_position(data)

    assert position.quantity == 3
    assert position.product == product
    assert position.order == order


@pytest.mark.django_db
def test_get_order_position_by_id():
    customer = Customer.objects.create(email="bob@example.com")
    product = Product.objects.create(name="Latte", roast="Medium", caffeine_type="decaf")
    order = Order.objects.create(customer=customer)

    position = OrderPosition.objects.create(quantity=2, product=product, order=order)
    found = get_order_position_by_id(position.id)

    assert found.id == position.id
    assert found.product == product
    assert found.order == order


@pytest.mark.django_db
def test_update_order_position():
    customer = Customer.objects.create(email="carol@example.com")
    product = Product.objects.create(name="Mocha", roast="Light", caffeine_type="regular")
    order = Order.objects.create(customer=customer)

    position = OrderPosition.objects.create(quantity=1, product=product, order=order)

    update_data = {
        "quantity": 5
    }

    updated = update_order_position(position.id, update_data)

    assert updated.quantity == 5


@pytest.mark.django_db
def test_delete_order_position():
    customer = Customer.objects.create(email="dave@example.com")
    product = Product.objects.create(name="Cappuccino", roast="Dark", caffeine_type="decaf")
    order = Order.objects.create(customer=customer)

    position = OrderPosition.objects.create(quantity=2, product=product, order=order)
    delete_order_position(position.id)

    assert not OrderPosition.objects.filter(id=position.id).exists()
