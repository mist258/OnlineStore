import pytest
from django.urls import reverse
from django.core.files.uploadedfile import SimpleUploadedFile
from rest_framework import status
from rest_framework.test import APIClient
from django.contrib.auth import get_user_model
from unittest.mock import patch
from apps.accessories.models import Accessory, AccessoryPhotosModel

UserModel = get_user_model()

@pytest.mark.django_db
class TestAccessoryPhotoPUT:
    @patch('cloudinary.uploader.upload_resource')
    def test_accessory_add_photo_put(self, mock_upload):
        """
        Test updating an accessory by adding a photo via PUT request.
        """
        # 1. Setup Mock
        mock_upload.return_value = 'test_public_id'
        
        # 2. Setup User & Client
        # Since DEFAULT_PERMISSION_CLASSES is IsSuperUser
        superuser = UserModel.objects.create_superuser(
            email="admin@test.com",
            password="Password123!"
        )
        client = APIClient()
        client.force_authenticate(user=superuser)
        
        # 3. Create initial Accessory
        accessory = Accessory.objects.create(
            sku="PUT-TEST-001",
            name="Original Accessory",
            price="15.00",
            quantity=10
        )
        
        # 4. Prepare File
        image_content = b'\x47\x49\x46\x38\x39\x61\x01\x00\x01\x00\x80\x00\x00\x05\x04\x04\x00\x00\x00\x2c\x00\x00\x00\x00\x01\x00\x01\x00\x00\x02\x02\x44\x01\x00\x3b'
        uploaded_file = SimpleUploadedFile(
            name='new_photo.gif',
            content=image_content,
            content_type='image/gif'
        )
        
        # 5. Perform PUT request
        # Endpoint: /api/accessories/<pk>/photo
        url = reverse('add_photo', kwargs={'pk': accessory.pk})
        response = client.put(url, {'photo1': uploaded_file}, format='multipart')
        
        # 6. Assertions
        assert response.status_code == status.HTTP_200_OK
        
        # Verify photo was created
        assert AccessoryPhotosModel.objects.filter(accessory=accessory).count() == 1
        photo_instance = AccessoryPhotosModel.objects.get(accessory=accessory)
        assert photo_instance.photo is not None
        
        # Verify response data
        assert response.data['id'] == accessory.id
        assert len(response.data['accessory_photos']) == 1
        assert mock_upload.called

    @patch('cloudinary.uploader.upload_resource')
    def test_accessory_add_multiple_photos_put(self, mock_upload):
        """
        Test adding multiple photos to an accessory via a single PUT request.
        """
        mock_upload.return_value = 'test_public_id_multi'
        
        superuser = UserModel.objects.create_superuser(
            email="admin_multi@test.com",
            password="Password123!"
        )
        client = APIClient()
        client.force_authenticate(user=superuser)
        
        accessory = Accessory.objects.create(
            sku="MULTI-PUT-TEST",
            name="Multi Photo Accessory",
            price="20.00",
            quantity=5
        )
        
        image_content = b'\x47\x49\x46\x38\x39\x61\x01\x00\x01\x00\x80\x00\x00\x05\x04\x04\x00\x00\x00\x2c\x00\x00\x00\x00\x01\x00\x01\x00\x00\x02\x02\x44\x01\x00\x3b'
        file1 = SimpleUploadedFile('photo1.gif', image_content, content_type='image/gif')
        file2 = SimpleUploadedFile('photo2.gif', image_content, content_type='image/gif')
        
        url = reverse('add_photo', kwargs={'pk': accessory.id})
        response = client.put(url, {'file1': file1, 'file2': file2}, format='multipart')
        
        assert response.status_code == status.HTTP_200_OK
        assert AccessoryPhotosModel.objects.filter(accessory=accessory).count() == 2
        assert len(response.data['accessory_photos']) == 2
        assert mock_upload.call_count == 2

    def test_accessory_add_photo_put_unauthorized(self):
        """
        Test that non-superusers cannot add photos.
        """
        client = APIClient()
        accessory = Accessory.objects.create(
            sku="PUT-TEST-UNAUTH",
            name="Unauth Accessory",
            price="15.00",
            quantity=10
        )
        
        url = reverse('add_photo', kwargs={'pk': accessory.pk})
        response = client.put(url, {}, format='multipart')
        
        assert response.status_code == status.HTTP_401_UNAUTHORIZED
