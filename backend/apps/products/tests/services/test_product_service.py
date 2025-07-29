from apps.products.models import Product

import pytest

from backend.apps.products.services.product_service import create_product, delete_product, get_product_by_id, update_product


@pytest.mark.django_db
def test_create_product():
    data = {
        "sku": "espresso_228",
        "name": "Espresso",
        "brend": "Jacobs",
        "roast": "Dark",
        "caffeine_type": "Decaf",
        "sort": "Arabica",
        "description": "Very good coffee!",
        "flavor_profiles": ["Bold", "Smoky"],
    }
    product = create_product(data)

    assert product.sku == "espresso_228"
    assert product.name == "Espresso"
    assert product.brend == "Jacobs"
    assert product.roast == "Dark"
    assert product.caffeine_type == "Decaf"
    assert product.sort == "Arabica"
    assert product.description == "Very good coffee!"
    assert product.flavor_profiles.count() == 2


@pytest.mark.django_db
def test_get_product_by_id():
    product = Product.objects.create(name="Latte", roast="Medium")
    found = get_product_by_id(product.id)

    assert found.id == product.id
    assert found.name == "Latte"


@pytest.mark.django_db
def test_update_product():
    product = Product.objects.create(
        sku="espresso_228",
        name="Latte",
        brend="Jacobs",
        caffeine_type="Decaf",
        sort="Robusta",
        roast="Medium",
        description="Very good coffee!"
    )
    update_data = {
        "sku": "espresso_420",
        "name": "Updated Latte",
        "brend": "Nescafe",
        "caffeine_type": "Regular",
        "sort": "Arabica",
        "roast": "Light", 
        "description": "So-so",
        "flavor_profiles": ["Mild"]
    }
    updated = update_product(product.id, update_data)

    assert updated.sku == "espresso_420"
    assert updated.name == "Updated Latte"
    assert updated.brend == "Nescafe"
    assert updated.caffeine_type == "Regular"
    assert updated.sort == "Arabica"
    assert updated.roast == "Light"
    assert updated.description == "So-so"
    assert updated.flavor_profiles.count() == 1


@pytest.mark.django_db
def test_delete_product():
    product = Product.objects.create(name="Temp", roast="None")
    delete_product(product.id)

    assert not Product.objects.filter(id=product.id).exists()
