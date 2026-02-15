import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient
from apps.accessories.models import Accessory, AccessoryPhotosModel
from decimal import Decimal

@pytest.mark.django_db
class TestAccessoryRemovePhotoView:

    @pytest.fixture
    def client(self):
        return APIClient()

    @pytest.fixture
    def accessory(self):
        return Accessory.objects.create(
            sku="TEST-SKU-001",
            name="Test Accessory",
            price=Decimal("10.00"),
            quantity=5
        )

    @pytest.fixture
    def photo(self, accessory):
        return AccessoryPhotosModel.objects.create(
            accessory=accessory,
            photo="http://example.com/photo1.jpg"
        )

    @pytest.fixture
    def other_accessory(self):
        return Accessory.objects.create(
            sku="TEST-SKU-002",
            name="Other Accessory",
            price=Decimal("20.00"),
            quantity=3
        )

    @pytest.fixture
    def other_photo(self, other_accessory):
        return AccessoryPhotosModel.objects.create(
            accessory=other_accessory,
            photo="http://example.com/photo2.jpg"
        )

    @pytest.fixture
    def admin_user(self, django_user_model):
        return django_user_model.objects.create_superuser(
            email="admin@example.com",
            password="password"
        )

    def test_remove_photo_success(self, client, accessory, photo, admin_user):
        """
        Test deleting a photo that belongs to the accessory.
        """
        client.force_authenticate(user=admin_user)
        # URL structure: /api/accessories/<accessory_id>/photos/<pk>
        # Assuming app namespace or structure. The file path replacement suggests:
        # /<int:accessory_id>/photos/<int:pk> is relative to the include path.
        # Ideally use reverse, but string construction validates the URL pattern change directly.
        
        url = f"/api/accessories/{accessory.id}/photos/{photo.id}"
        
        response = client.delete(url)
        
        assert response.status_code == status.HTTP_204_NO_CONTENT
        assert not AccessoryPhotosModel.objects.filter(id=photo.id).exists()

    def test_remove_photo_not_found(self, client, accessory, admin_user):
        """
        Test deleting a non-existent photo.
        """
        client.force_authenticate(user=admin_user)
        url = f"/api/accessories/{accessory.id}/photos/99999"
        
        response = client.delete(url)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND

    def test_remove_photo_wrong_accessory(self, client, accessory, other_photo, admin_user):
        """
        Test deleting a photo that exists but belongs to a different accessory.
        Should return 404 because of the queryset filtering.
        """
        client.force_authenticate(user=admin_user)
        # Try to delete 'other_photo' via 'accessory' endpoint
        url = f"/api/accessories/{accessory.id}/photos/{other_photo.id}"
        
        response = client.delete(url)
        
        assert response.status_code == status.HTTP_404_NOT_FOUND
        # Confirm photo was NOT deleted
        assert AccessoryPhotosModel.objects.filter(id=other_photo.id).exists()
