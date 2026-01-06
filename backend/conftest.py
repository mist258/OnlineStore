import datetime
import uuid

from django.core.management import call_command

from rest_framework.test import APIClient

from apps.accessories.models import Accessory
from apps.basket.models import Basket, BasketItem, DiscountCode
from apps.favorites.services.favorites_service import FavoritesService
from apps.orders.models import Order, OrderPosition
from apps.products.models import Product
from apps.supplies.models import Supply
from apps.users.models import UserModel, UserProfileModel

import pytest
import pytz

# @pytest.fixture(scope="session", autouse=True)
# def apply_migrations(django_db_setup, django_db_blocker):
#     with django_db_blocker.unblock():
#         call_command("migrate", run_syncdb=True, verbosity=2)
        
@pytest.fixture
def uuid_token():
    return str(uuid.uuid4())


@pytest.fixture
def api_client():
    return APIClient()


@pytest.fixture
def admin_user(db):
    return UserModel.objects.create_superuser(
        email="admin@example.com",
        password="adminpass123",
        is_staff=True,
        is_superuser=True
    )


@pytest.fixture
def user():
    return UserModel.objects.create_user(
        email='test@example.com',
        password='testpass123'
    )


@pytest.fixture
def user_profile(user):
    return UserProfileModel.objects.create(
        user=user,
        first_name='John',
        last_name='Doe',
        country='US',
        phone_number='+1234567890'
    )


@pytest.fixture
def other_user():
    return UserModel.objects.create_user(
        email='other@example.com',
        password='othertestpass123'
    )


@pytest.fixture
def product():
    product = Product.objects.create(name='Test Product')
    return product


@pytest.fixture
def basket(user):
    return Basket.objects.create(user=user)


@pytest.fixture
def basket_item(basket, product, supply):
    return BasketItem.objects.create(
        basket=basket,
        product=product,
        supply=supply,
        quantity=2,
    )

    
@pytest.fixture
def guest_basket():
    return Basket.objects.create(guest_token=str(uuid.uuid4()))


@pytest.fixture
def order(user):
    return Order.objects.create(
        customer=user
    )
    

@pytest.fixture
def order_position(product, order):
    return OrderPosition.objects.create(
        order=order,
        product=product,
        quantity=2
    )


@pytest.fixture
def supply(product):
    return Supply.objects.create(product=product, price=100.0, quantity=10)


@pytest.fixture
def discount_code():
    return DiscountCode.objects.create(
        code="SAVE50", 
        description="Save 50%",
        discount_percent=50,
        active=True,
        valid_from=datetime.datetime(2023, 1, 1, 0, 0, 0, tzinfo=pytz.UTC),
        valid_to=datetime.datetime(2028, 1, 1, 0, 0, 0, tzinfo=pytz.UTC)
    )


@pytest.fixture
def favorites(user):
    return FavoritesService.get_or_create_favorites(user)


@pytest.fixture
def favorites_item(favorites, product):
    return FavoritesService.add_item_to_favorites(favorites, product)


@pytest.fixture
def accessory():
    return Accessory.objects.create(
            sku='4984984',
            name='Test Accessory',
            price=29.99,
            quantity=100
        )


@pytest.fixture
def product_photo(product):
    """Create a photo for a product"""
    from apps.products.models import Photo
    return Photo.objects.create(
        product=product,
        url='https://example.com/product-image-1.jpg',
        position=0
    )


@pytest.fixture
def product_photos(product):
    """Create multiple photos for a product"""
    from apps.products.models import Photo
    photos = []
    for i in range(3):
        photo = Photo.objects.create(
            product=product,
            url=f'https://example.com/product-image-{i+1}.jpg',
            position=i
        )
        photos.append(photo)
    return photos


@pytest.fixture
def accessory_photo(accessory):
    """Create a photo for an accessory"""
    from apps.products.models import Photo
    return Photo.objects.create(
        accessory=accessory,
        url='https://example.com/accessory-image-1.jpg',
        position=0
    )


@pytest.fixture
def accessory_photos(accessory):
    """Create multiple photos for an accessory"""
    from apps.products.models import Photo
    photos = []
    for i in range(3):
        photo = Photo.objects.create(
            accessory=accessory,
            url=f'https://example.com/accessory-image-{i+1}.jpg',
            position=i
        )
        photos.append(photo)
    return photos


@pytest.fixture
def order_position_with_product(product, order):
    """Create an order position with a product"""
    return OrderPosition.objects.create(
        order=order,
        product=product,
        price=100.0,
        quantity=2
    )


@pytest.fixture
def order_position_with_accessory(accessory, order):
    """Create an order position with an accessory"""
    return OrderPosition.objects.create(
        order=order,
        accessory=accessory,
        price=29.99,
        quantity=1
    )
