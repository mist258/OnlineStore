import pytest
from apps.check_deployment.models import FlavorProfile
from apps.check_deployment.services.flavor_profile_service import (
    create_flavor_profile,
    get_flavor_profile_by_id,
    update_flavor_profile,
    delete_flavor_profile
)

@pytest.mark.django_db
def test_create_flavor_profile():
    data = {
        "name": "Smoky"
    }
    flavor_profile = create_flavor_profile(data)

    assert flavor_profile.name == "Smoky"


@pytest.mark.django_db
def test_get_flavor_profile():
    flavor_profile = FlavorProfile.objects.create(name="Smoky")
    found = get_flavor_profile_by_id(flavor_profile.id)

    assert found.id == flavor_profile.id
    assert found.name == "Smoky"


@pytest.mark.django_db
def test_update_flavor_profile():
    flavor_profile = FlavorProfile.objects.create(name="Smoky")
    update_data = {
        "name": "Very Smoky"
    }
    updated = update_flavor_profile(flavor_profile.id, update_data)

    assert updated.name == "Very Smoky"
    

@pytest.mark.django_db
def test_delete_flavor_profile():
    flavor_profile = FlavorProfile.objects.create(name="Smoky")
    delete_flavor_profile(flavor_profile.id)

    assert not FlavorProfile.objects.filter(id=flavor_profile.id).exists()