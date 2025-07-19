from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.database_products.db_utils import get_object_or_error
from apps.database_products.models import Subscription


@transaction.atomic
def create_subscription(data: dict) -> Subscription:
    name = data.get("name")
    letter = data.get("letter")

    if not name:
        raise ValidationError("Subscription 'name' field is required.")
    if not letter:
        raise ValidationError("Subscription 'letter' field is required.")

    try:
        subscription = Subscription.objects.create(
            name=name,
            letter=letter
        )
    except IntegrityError as e:
        raise ValidationError(f"Database error during subscription creation: {str(e)}")
    except Exception as e:
        raise ValidationError(f"Unexpected error: {str(e)}")

    return subscription


def get_subscription_by_id(subscription_id: int) -> Subscription:
    return get_object_or_error(Subscription, subscription_id)


@transaction.atomic
def update_subscription(subscription_id: int, data: dict) -> Subscription:
    subscription = get_object_or_error(Subscription, subscription_id)

    if "name" in data:
        subscription.name = data["name"]
    if "letter" in data:
        subscription.letter = data["letter"]

    subscription.save()
    return subscription


@transaction.atomic
def delete_subscription(subscription_id: int) -> None:
    subscription = get_object_or_error(Subscription, subscription_id)

    try:
        subscription.delete()
    except Subscription.DoesNotExist:
        raise ValueError(f"Subscription with id {subscription_id} not found.")
    except IntegrityError as e:
        raise ValueError(f"Cannot delete subscription {subscription_id}: {str(e)}")
