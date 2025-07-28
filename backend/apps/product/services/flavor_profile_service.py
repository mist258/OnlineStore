from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.db_utils import get_object_or_error
from apps.product.models import FlavorProfile


def get_flavor_profile_by_id(flavor_profile_id: int) -> FlavorProfile:
    return get_object_or_error(FlavorProfile, flavor_profile_id)


@transaction.atomic
def create_flavor_profile(data: dict) -> FlavorProfile:
     # check required fields
    flavor_name = data.get("name")
    if not flavor_name:
        raise ValidationError("FlavorProfile 'name' is required.")

    try:
        return FlavorProfile.objects.create(name=flavor_name)
    except IntegrityError as e:
        raise ValidationError(f"Database error: {str(e)}")
    except Exception as e:
        raise ValidationError(f"Unexpected error: {str(e)}")

    
@transaction.atomic
def update_flavor_profile(flavor_profile_id: int, data:dict) -> FlavorProfile:
    flavor_profile = get_object_or_error(FlavorProfile, flavor_profile_id)
    
    if "name" in data:
        flavor_profile.name = data["name"]

    flavor_profile.save()
    return flavor_profile


@transaction.atomic
def delete_flavor_profile(flavor_profile_id: int) -> None:
    flavor_profile = get_object_or_error(FlavorProfile, flavor_profile_id)

    try:
        flavor_profile.delete()
    except IntegrityError as e:
        raise ValueError(f"Failed to delete FlavorProfile {flavor_profile_id}: {e}")
