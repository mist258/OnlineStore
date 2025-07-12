import pytest
from apps.check_deployment.models import Product
from apps.check_deployment.services.product_service import (
    create_product,
    delete_product,
    get_product_by_id,
    update_product
)

@pytest.mark.django_db
def test_create_product():
    data = {
        "name": "Espresso",
        "roast": "Dark",
        "caffeine_type": "decaf",
        "flavor_profiles": ["Bold", "Smoky"],
    }
    product = create_product(data)

    assert product.name == "Espresso"
    assert product.roast == "Dark"
    assert product.flavor_profiles.count() == 2


@pytest.mark.django_db
def test_get_product_by_id():
    product = Product.objects.create(name="Latte", roast="Medium")
    found = get_product_by_id(product.id)

    assert found.id == product.id
    assert found.name == "Latte"


@pytest.mark.django_db
def test_update_product():
    product = Product.objects.create(name="Latte", roast="Medium")
    update_data = {
        "name": "Updated Latte",
        "roast": "Light",
        "flavor_profiles": ["Mild"]
    }
    updated = update_product(product.id, update_data)

    assert updated.name == "Updated Latte"
    assert updated.roast == "Light"
    assert updated.flavor_profiles.count() == 1


@pytest.mark.django_db
def test_delete_product():
    product = Product.objects.create(name="Temp", roast="None")
    delete_product(product.id)

    assert not Product.objects.filter(id=product.id).exists()
