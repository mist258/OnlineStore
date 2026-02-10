import pytest
from apps.products.models import Photo, Product
from apps.accessories.models import Accessory

@pytest.mark.django_db
def test_photo_str_with_null_product():
    """
    Test that Photo.__str__ doesn't crash when product is None.
    This happens when a Photo is linked to an Accessory instead of a Product.
    """
    # 1. Create an Accessory (since Photo has an accessory field)
    accessory = Accessory.objects.create(
        sku="ACC-001",
        name="Test Accessory",
        price="5.00",
        quantity=10
    )
    
    # 2. Create a Photo linked to the Accessory, NOT the Product
    photo = Photo.objects.create(
        url="http://example.com/photo.jpg",
        accessory=accessory,
        product=None
    )
    
    # 3. Accessing __str__ should not raise AttributeError
    try:
        representation = str(photo)
        assert "http://example.com/photo.jpg" in representation
    except AttributeError as e:
        pytest.fail(f"Photo.__str__ raised AttributeError: {e}")

@pytest.mark.django_db
def test_photo_str_with_product():
    """
    Test that Photo.__str__ works correctly when linked to a Product.
    """
    product = Product.objects.create(
        sku="PROD-001",
        name="Test Product"
    )
    
    photo = Photo.objects.create(
        url="http://example.com/product_photo.jpg",
        product=product
    )
    
    assert "Test Product" in str(photo)
