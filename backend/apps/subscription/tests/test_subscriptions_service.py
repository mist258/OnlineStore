from apps.subscription.models import Subscription

import pytest

from apps.subscription.services.subscription_service import (
    create_subscription,
    delete_subscription,
    get_subscription_by_id,
    update_subscription,
)


@pytest.mark.django_db
def test_create_subscription():
    data = {
        "name": "Weekly Newsletter",
        "letter": "W"
    }
    subscription = create_subscription(data)

    assert subscription.name == "Weekly Newsletter"
    assert subscription.letter == "W"


@pytest.mark.django_db
def test_get_subscription_by_id():
    subscription = Subscription.objects.create(name="Monthly Digest", letter="M")
    found = get_subscription_by_id(subscription.id)

    assert found.id == subscription.id
    assert found.name == "Monthly Digest"
    assert found.letter == "M"


@pytest.mark.django_db
def test_update_subscription():
    subscription = Subscription.objects.create(name="Daily Update", letter="D")
    update_data = {
        "name": "Daily News Update",
        "letter": "DN"
    }
    updated = update_subscription(subscription.id, update_data)

    assert updated.name == "Daily News Update"
    assert updated.letter == "DN"


@pytest.mark.django_db
def test_delete_subscription():
    subscription = Subscription.objects.create(name="Special Offers", letter="S")
    delete_subscription(subscription.id)

    assert not Subscription.objects.filter(id=subscription.id).exists()
