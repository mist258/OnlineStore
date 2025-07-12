import pytest
from apps.check_deployment.models import Product, Supply
from apps.check_deployment.services.supply_service import (
    create_supply,
    get_supply_by_id,
    update_supply,
    delete_supply,
)


@pytest.mark.django_db
def test_create_supply():
    product = Product.objects.create(name="Espresso", roast="Dark", caffeine_type="regular")
    data = {
        "product_id": product.id,
        "grind": "medium",
        "price": 15.50,
        "weight": 250.0,
        "quantity": 10,
    }
    supply = create_supply(data)

    assert supply.product.id == product.id
    assert supply.grind == "medium"
    assert float(supply.price) == 15.50
    assert float(supply.weight) == 250.0
    assert supply.quantity == 10


@pytest.mark.django_db
def test_get_supply_by_id():
    product = Product.objects.create(name="Espresso", roast="Medium", caffeine_type="decaf")
    supply = Supply.objects.create(
        product=product, grind="coarse", price=10.00, weight=200.0, quantity=5
    )
    found = get_supply_by_id(supply.id)

    assert found.id == supply.id
    assert found.grind == "coarse"


@pytest.mark.django_db
def test_update_supply():
    product = Product.objects.create(name="Latte", roast="Light", caffeine_type="regular")
    supply = Supply.objects.create(
        product=product, grind="fine", price=8.00, weight=100.0, quantity=3
    )
    update_data = {
        "grind": "medium-fine",
        "price": 9.00,
        "quantity": 6
    }
    updated = update_supply(supply.id, update_data)

    assert updated.grind == "medium-fine"
    assert float(updated.price) == 9.00
    assert updated.quantity == 6


@pytest.mark.django_db
def test_delete_supply():
    product = Product.objects.create(name="Mocha", roast="Dark", caffeine_type="decaf")
    supply = Supply.objects.create(
        product=product, grind="medium", price=12.00, weight=300.0, quantity=7
    )
    delete_supply(supply.id)

    assert not Supply.objects.filter(id=supply.id).exists()
