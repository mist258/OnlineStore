from datetime import date
from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.database_products.db_utils import get_object_or_error
from apps.database_products.models import Review, Customer, Product


@transaction.atomic
def create_review(data: dict) -> Review:
    grade = data.get("grade")
    customer_id = data.get("customer_id")
    product_id = data.get("product_id")

    if grade is None:
        raise ValidationError("Review 'grade' is required.")
    if customer_id is None:
        raise ValidationError("Review 'customer_id' is required.")
    if product_id is None:
        raise ValidationError("Review 'product_id' is required.")

    customer = get_object_or_error(Customer, customer_id)
    product = get_object_or_error(Product, product_id)

    try:
        review = Review.objects.create(
            grade=grade,
            date=data.get("date", date.today()),
            comment=data.get("comment"),
            customer=customer,
            product=product
        )
    except IntegrityError as e:
        raise ValidationError(f"Database error during review creation: {str(e)}")
    except Exception as e:
        raise ValidationError(f"Unexpected error: {str(e)}")

    return review


def get_review_by_id(review_id: int) -> Review:
    return get_object_or_error(Review, review_id)


@transaction.atomic
def update_review(review_id: int, data: dict) -> Review:
    review = get_object_or_error(Review, review_id)

    if "grade" in data:
        review.grade = data["grade"]
    if "date" in data:
        review.date = data["date"]
    if "comment" in data:
        review.comment = data["comment"]
    if "customer_id" in data:
        review.customer = get_object_or_error(Customer, data["customer_id"])
    if "product_id" in data:
        review.product = get_object_or_error(Product, data["product_id"])

    review.save()
    return review


@transaction.atomic
def delete_review(review_id: int) -> None:
    review = get_object_or_error(Review, review_id)

    try:
        review.delete()
    except Review.DoesNotExist:
        raise ValueError(f"Review with id {review_id} not found.")
    except IntegrityError as e:
        raise ValueError(f"Cannot delete review {review_id}: {str(e)}")
