import pytest
from django.core.management import call_command
from rest_framework.test import APIClient

from apps.users.models import UserModel, UserProfileModel
from apps.orders.models import Order, OrderPosition
from apps.products.models import Product
from apps.supplies.models import Supply
from apps.basket.models import Basket, BasketItem
from apps.basket.models import DiscountCode
import uuid


@pytest.fixture(scope="session", autouse=True)
def apply_migrations(django_db_setup, django_db_blocker):
    with django_db_blocker.unblock():
        call_command("migrate", run_syncdb=True, verbosity=2)
        

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
def guest_basket():
    return Basket.objects.create(guest_token=str(uuid.uuid4()))


@pytest.fixture
def order(user, user_profile):
    return Order.objects.create(
        customer=user,
        billing_details=user_profile
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
    return DiscountCode.objects.create(code="SAVE10", amount=10.0, is_percentage=False)