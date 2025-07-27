import pytest
from apps.database_products.models import Product, Supply
from backend.apps.supply.services.supply_service import (
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
        "serving_type": "Ground",
        "price": 15.50,
        "weight": 250.0,
        "quantity": 10,
    }
    supply = create_supply(data)

    assert supply.product.id == product.id
    assert supply.serving_type == "Ground"
    assert float(supply.price) == 15.50
    assert float(supply.weight) == 250.0
    assert supply.quantity == 10


@pytest.mark.django_db
def test_get_supply_by_id():
    product = Product.objects.create(name="Espresso", roast="Medium", caffeine_type="decaf")
    supply = Supply.objects.create(
        product=product, serving_type="coarse", price=10.00, weight=200.0, quantity=5
    )
    found = get_supply_by_id(supply.id)

    assert found.id == supply.id
    assert found.serving_type == "coarse"


@pytest.mark.django_db
def test_update_supply():
    product = Product.objects.create(name="Latte", roast="Light", caffeine_type="regular")
    supply = Supply.objects.create(
        product=product, serving_type="In capsules", price=8.00, weight=100.0, quantity=3
    )
    update_data = {
        "serving_type": "In grains",
        "price": 9.00,
        "quantity": 6
    }
    updated = update_supply(supply.id, update_data)

    assert updated.serving_type == "In grains"
    assert float(updated.price) == 9.00
    assert updated.quantity == 6


@pytest.mark.django_db
def test_delete_supply():
    product = Product.objects.create(name="Mocha", roast="Dark", caffeine_type="decaf")
    supply = Supply.objects.create(
        product=product, serving_type="Ground", price=12.00, weight=300.0, quantity=7
    )
    delete_supply(supply.id)

    assert not Supply.objects.filter(id=supply.id).exists()
