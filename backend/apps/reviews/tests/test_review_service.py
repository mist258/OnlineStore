from apps.reviews.models import Review
from apps.users.models import UserModel

import pytest

from backend.apps.reviews.services.review_service import create_review, delete_review, get_review_by_id, update_review


@pytest.mark.django_db
def test_create_review():
    customer = UserModel.objects.create(email="john@example.com")

    data = {
        "grade": 5,
        "comment": "Excellent flavor and packaging.",
        "customer_id": customer.id,
    }

    review = create_review(data)

    assert review.grade == 5
    assert review.comment == "Excellent flavor and packaging."
    assert review.customer == customer


@pytest.mark.django_db
def test_get_review_by_id():
    customer = UserModel.objects.create(email="jane@example.com")
    review = Review.objects.create(
        grade=4,
        comment="Smooth taste.",
        customer=customer,
    )

    found = get_review_by_id(review.id)

    assert found.id == review.id
    assert found.grade == 4
    assert found.customer == customer


@pytest.mark.django_db
def test_update_review():
    customer = UserModel.objects.create(email="oliver@example.com")
    review = Review.objects.create(
        grade=2,
        comment="Too bitter.",
        customer=customer,
    )

    update_data = {
        "grade": 3,
        "comment": "Got better after a second try.",
    }

    updated = update_review(review.id, update_data)

    assert updated.grade == 3
    assert updated.comment == "Got better after a second try."


@pytest.mark.django_db
def test_delete_review():
    customer = UserModel.objects.create(email="emma@example.com")
    review = Review.objects.create(
        grade=1,
        comment="Very bad packaging.",
        customer=customer,
    )

    delete_review(review.id)

    assert not Review.objects.filter(id=review.id).exists()
