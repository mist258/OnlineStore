from django.core.exceptions import ValidationError

from apps.basket.models import Basket, BasketItem, DiscountCode
from apps.basket.services.basket_service import (
    add_item_to_basket,
    clear_basket,
    get_basket_total,
    migrate_guest_basket_to_user,
    remove_product_from_basket,
)
from apps.products.models import Accessory, Product
from apps.supplies.models import Supply
from apps.users.models import UserModel

import pytest


@pytest.mark.django_db
def test_add_product_to_basket():
    # Setup
    user = UserModel.objects.create(email="test@example.com")
    basket = Basket.objects.create(user=user)
    product = Product.objects.create(name="Test Product")
    supply = Supply.objects.create(product=product, price=100.0, quantity=10)

    # Test adding product
    basket_item = add_item_to_basket(
        basket=basket,
        product=product,
        supply=supply,
        quantity=2,
    )

    # Assertions
    assert basket_item.basket == basket
    assert basket_item.product == product
    assert basket_item.quantity == 2


@pytest.mark.django_db
def test_migrate_guest_basket_to_user():
    # Setup
    user = UserModel.objects.create(email="user@example.com")
    discount_code = DiscountCode.objects.create(code="DISCOUNT10", description="10% off", discount_percent=10)
    guest_token = "123e4567-e89b-12d3-a456-426614174000"
    guest_basket = Basket.objects.create(guest_token=guest_token, is_active=True, discount_code=discount_code)
    
    product = Product.objects.create(name="Test Product")
    supply = Supply.objects.create(product=product, price=100.0, quantity=10)
    
    BasketItem.objects.create(
        basket=guest_basket,
        product=product,
        supply=supply,
        quantity=2
    )

    # Test migration
    result = migrate_guest_basket_to_user(guest_token, user)

    # Assertions
    assert result["success"] is True
    assert result["items_migrated"] == 1
    
    # Check guest basket is inactive
    guest_basket.refresh_from_db()
    assert guest_basket.is_active is False
    assert result["user_basket_id"] == user.baskets.first().id
    assert result["discount_code"] == discount_code.code


@pytest.mark.django_db
def test_get_basket_total():
    # Setup
    user = UserModel.objects.create(email="test@example.com")
    basket = Basket.objects.create(user=user)
    
    product1 = Product.objects.create(sku="1", name="Product 1")
    product2 = Product.objects.create(sku="2", name="Product 2")
    accessory1 = Accessory.objects.create(name="Accessory 1", price=50.0, quantity=10)
    
    supply1 = Supply.objects.create(product=product1, price=100.0, quantity=10)
    supply2 = Supply.objects.create(product=product2, price=200.0, quantity=5)
    
    BasketItem.objects.create(
        basket=basket,
        product=product1,
        supply=supply1,
        quantity=2
    )
    BasketItem.objects.create(
        basket=basket,
        product=product2,
        supply=supply2,
        quantity=1
    )
    
    BasketItem.objects.create(
        basket=basket,
        accessory=accessory1,
        quantity=1
    )

    # Test total calculation
    total = get_basket_total(basket.id)

    # Assertions
    assert total == 450.0  # (2 * 100) + (1 * 200)


@pytest.mark.django_db
def test_clear_basket():
    # Setup
    user = UserModel.objects.create(email="test@example.com")
    basket = Basket.objects.create(user=user)
    
    product = Product.objects.create(name="Test Product")
    supply = Supply.objects.create(product=product, price=100.0, quantity=10)
    
    BasketItem.objects.create(
        basket=basket,
        product=product,
        supply=supply,
        quantity=2
    )

    # Test clearing basket
    clear_basket(basket.id)

    # Assertions
    basket.refresh_from_db()
    assert basket.items.count() == 0
    assert basket.is_active is False


@pytest.mark.django_db
def test_remove_product_from_basket():
    # Setup
    user = UserModel.objects.create(email="test@example.com")
    basket = Basket.objects.create(user=user)
    product = Product.objects.create(name="Test Product")
    supply = Supply.objects.create(product=product, price=100.0, quantity=10)
    
    basket_item = BasketItem.objects.create(
        basket=basket,
        product=product,
        supply=supply,
        quantity=2
    )

    # Test removing item
    remove_product_from_basket(basket_item.id)

    # Assertions
    assert not BasketItem.objects.filter(id=basket_item.id).exists()