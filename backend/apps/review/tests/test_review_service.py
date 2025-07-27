import pytest
from datetime import date

from apps.database_products.models import Review, Customer, Product
from backend.apps.review.services.review_service import (
    create_review,
    get_review_by_id,
    update_review,
    delete_review
)


@pytest.mark.django_db
def test_create_review():
    customer = Customer.objects.create(email="john@example.com", is_guest=False)
    product = Product.objects.create(name="Espresso", roast="Dark", caffeine_type="regular")

    data = {
        "grade": 5,
        "comment": "Excellent flavor and packaging.",
        "customer_id": customer.id,
        "product_id": product.id,
        "date": date(2024, 6, 10)
    }

    review = create_review(data)

    assert review.grade == 5
    assert review.comment == "Excellent flavor and packaging."
    assert review.customer == customer
    assert review.product == product
    assert review.date == date(2024, 6, 10)


@pytest.mark.django_db
def test_get_review_by_id():
    customer = Customer.objects.create(email="jane@example.com")
    product = Product.objects.create(name="Latte", roast="Medium", caffeine_type="decaf")
    review = Review.objects.create(
        grade=4,
        date=date.today(),
        comment="Smooth taste.",
        customer=customer,
        product=product
    )

    found = get_review_by_id(review.id)

    assert found.id == review.id
    assert found.grade == 4
    assert found.customer == customer
    assert found.product == product


@pytest.mark.django_db
def test_update_review():
    customer = Customer.objects.create(email="oliver@example.com")
    product = Product.objects.create(name="Mocha", roast="Light", caffeine_type="regular")
    review = Review.objects.create(
        grade=2,
        date=date(2024, 1, 15),
        comment="Too bitter.",
        customer=customer,
        product=product
    )

    update_data = {
        "grade": 3,
        "comment": "Got better after a second try.",
        "date": date(2024, 2, 1)
    }

    updated = update_review(review.id, update_data)

    assert updated.grade == 3
    assert updated.comment == "Got better after a second try."
    assert updated.date == date(2024, 2, 1)


@pytest.mark.django_db
def test_delete_review():
    customer = Customer.objects.create(email="emma@example.com")
    product = Product.objects.create(name="Cappuccino", roast="Dark", caffeine_type="decaf")
    review = Review.objects.create(
        grade=1,
        date=date.today(),
        comment="Very bad packaging.",
        customer=customer,
        product=product
    )

    delete_review(review.id)

    assert not Review.objects.filter(id=review.id).exists()
