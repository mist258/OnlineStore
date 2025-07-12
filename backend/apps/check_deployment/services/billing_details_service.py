from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.check_deployment.db_utils import get_object_or_error
from apps.check_deployment.models import BillingDetails, Order, Customer


@transaction.atomic
def create_billing_details(data: dict) -> BillingDetails:
    # Required fields validation
    first_name = data.get("first_name")
    last_name = data.get("last_name")
    province = data.get("province")
    city = data.get("city")
    zip_code = data.get("zip_code")
    phone = data.get("phone")

    if not first_name:
        raise ValidationError("BillingDetails 'first_name' is required.")
    if not last_name:
        raise ValidationError("BillingDetails 'last_name' is required.")
    if not province:
        raise ValidationError("BillingDetails 'province' is required.")
    if not city:
        raise ValidationError("BillingDetails 'city' is required.")
    if not zip_code:
        raise ValidationError("BillingDetails 'zip_code' is required.")
    if not phone:
        raise ValidationError("BillingDetails 'phone' is required.")

    order = None
    if "order_id" in data:
        order = get_object_or_error(Order, data["order_id"])

    customer = None
    if "customer_id" in data:
        customer = get_object_or_error(Customer, data["customer_id"])

    try:
        billing = BillingDetails.objects.create(
            first_name=first_name,
            last_name=last_name,
            company_name=data.get("company_name"),
            province=province,
            city=city,
            address_1=data.get("address_1"),
            address_2=data.get("address_2"),
            zip_code=zip_code,
            phone=phone,
            is_configuration=data.get("is_configuration", False),
            order=order,
            customer=customer,
        )
    except IntegrityError as e:
        raise ValidationError(f"Database error during billing details creation: {str(e)}")
    except Exception as e:
        raise ValidationError(f"Unexpected error: {str(e)}")

    return billing


def get_billing_details_by_id(billing_id: int) -> BillingDetails:
    return get_object_or_error(BillingDetails, billing_id)


@transaction.atomic
def update_billing_details(billing_id: int, data: dict) -> BillingDetails:
    billing = get_object_or_error(BillingDetails, billing_id)

    for field in [
        "first_name",
        "last_name",
        "company_name",
        "province",
        "city",
        "address_1",
        "address_2",
        "zip_code",
        "phone",
        "is_configuration",
    ]:
        if field in data:
            setattr(billing, field, data[field])

    if "order_id" in data:
        billing.order = get_object_or_error(Order, data["order_id"])

    if "customer_id" in data:
        billing.customer = get_object_or_error(Customer, data["customer_id"])

    billing.save()
    return billing


@transaction.atomic
def delete_billing_details(billing_id: int) -> None:
    billing = get_object_or_error(BillingDetails, billing_id)

    try:
        billing.delete()
    except BillingDetails.DoesNotExist:
        raise ValueError(f"BillingDetails with id {billing_id} not found.")
    except IntegrityError as e:
        raise ValueError(f"Cannot delete billing details {billing_id}: {str(e)}")
