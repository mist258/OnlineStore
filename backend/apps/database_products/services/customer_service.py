from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.database_products.db_utils import get_object_or_error
from apps.database_products.models import Customer, Subscription


@transaction.atomic
def create_customer(data: dict) -> Customer:
    email = data.get("email")
    if not email:
        raise ValidationError("Customer 'email' field is required.")

    password = data.get("password")
    is_guest = data.get("is_guest", True)

    try:
        customer = Customer.objects.create(
            email=email,
            password=password,
            is_guest=is_guest,
        )
    except IntegrityError as e:
        raise ValidationError(f"Database error during customer creation: {str(e)}")
    except Exception as e:
        raise ValidationError(f"Unexpected error: {str(e)}")

    # Handle subscriptions if provided
    subscription_ids = data.get("subscription_ids", [])
    if subscription_ids:
        subscriptions = Subscription.objects.filter(id__in=subscription_ids)
        customer.subscriptions.set(subscriptions)

    return customer


def get_customer_by_id(customer_id: int) -> Customer:
    return get_object_or_error(Customer, customer_id)


@transaction.atomic
def update_customer(customer_id: int, data: dict) -> Customer:
    customer = get_object_or_error(Customer, customer_id)

    if "email" in data:
        customer.email = data["email"]
    if "password" in data:
        customer.password = data["password"]
    if "is_guest" in data:
        customer.is_guest = data["is_guest"]

    customer.save()

    if "subscription_ids" in data:
        subscriptions = Subscription.objects.filter(id__in=data["subscription_ids"])
        customer.subscriptions.set(subscriptions)

    return customer


@transaction.atomic
def delete_customer(customer_id: int) -> None:
    customer = get_object_or_error(Customer, customer_id)

    try:
        customer.delete()
    except Customer.DoesNotExist:
        raise ValueError(f"Customer with id {customer_id} not found.")
    except IntegrityError as e:
        raise ValueError(f"Cannot delete customer {customer_id}: {str(e)}")
