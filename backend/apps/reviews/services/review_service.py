from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction


from apps.reviews.models import Review

from backend.apps.db_utils import get_object_or_error

UserModel = get_user_model()


@transaction.atomic
def create_review(data: dict) -> Review:
    grade = data.get("grade")
    customer_id = data.get("customer_id")

    if grade is None:
        raise ValidationError("Review 'grade' is required.")
    if customer_id is None:
        raise ValidationError("Review 'customer_id' is required.")

    customer = get_object_or_error(UserModel, customer_id)

    try:
        review = Review.objects.create(
            grade=grade,
            comment=data.get("comment"),
            customer=customer,
        )
    except IntegrityError as e:
        raise ValidationError(f"Database error during reviews creation: {str(e)}")
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
    if "comment" in data:
        review.comment = data["comment"]
    if "customer_id" in data:
        review.customer = get_object_or_error(UserModel, data["customer_id"])

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
        raise ValueError(f"Cannot delete reviews {review_id}: {str(e)}")
