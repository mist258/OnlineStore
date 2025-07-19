import pytest
from django.core.exceptions import ValidationError
from apps.database_products.models import Product, Photo
from apps.database_products.services.photo_service import (
    create_photo,
    update_photo,
    delete_photo,
    get_photo_by_id,
)


@pytest.mark.django_db
def test_create_photo_success():
    product = Product.objects.create(
        sku="latte_228",
        name="Latte", 
        roast="Light", 
        caffeine_type="regular"
    )
    data = {
        "product_id": product.id,
        "url": "latte_1.jpg",
        "position": 1
    }

    photo = create_photo(data)

    assert photo.url == "latte_1.jpg"
    assert photo.position == 1
    assert photo.product.id == product.id


@pytest.mark.django_db
def test_create_photo_without_product_raises():
    data = {
        "product_id": 9999,
        "url": "ghost.jpg",
        "position": 0
    }

    with pytest.raises(
        ValidationError, 
        match=f"Product with id {data.get('product_id')} not found."
    ):
        create_photo(data)


@pytest.mark.django_db
def test_update_photo_fields():
    product = Product.objects.create(
        sku="latte_228",
        name="Espresso", 
        roast="Dark", 
        caffeine_type="regular"
    )
    photo = Photo.objects.create(product=product, url="old.jpg", position=0)

    new_data = {
        "url": "updated.jpg",
        "position": 2
    }

    updated = update_photo(photo.id, new_data)

    assert updated.url == "updated.jpg"
    assert updated.position == 2


@pytest.mark.django_db
def test_update_photo_product():
    product1 = Product.objects.create(
        sku="latte_228",
        name="Arabica", 
        roast="Light", 
        caffeine_type="decaf"
    )
    product2 = Product.objects.create(
        sku="latte_229",
        name="Robusta", 
        roast="Dark", 
        caffeine_type="regular"
    )
    photo = Photo.objects.create(
        product=product1, 
        url="product1.jpg", 
        position=0
    )

    updated = update_photo(photo.id, {"product_id": product2.id})

    assert updated.product.id == product2.id


@pytest.mark.django_db
def test_delete_photo():
    product = Product.objects.create(
        sku="latte_228",
        name="Test", 
        roast="Medium", 
        caffeine_type="regular"
    )
    photo = Photo.objects.create(product=product, url="to_delete.jpg", position=0)

    delete_photo(photo.id)

    with pytest.raises(Photo.DoesNotExist):
        Photo.objects.get(id=photo.id)


@pytest.mark.django_db
def test_get_photo_by_id():
    product = Product.objects.create(
        sku="latte_228",
        name="Flat White", 
        roast="Medium", 
        caffeine_type="regular"
    )
    photo = Photo.objects.create(product=product, url="flat.jpg", position=3)

    result = get_photo_by_id(photo.id)

    assert result.id == photo.id
    assert result.url == "flat.jpg"
