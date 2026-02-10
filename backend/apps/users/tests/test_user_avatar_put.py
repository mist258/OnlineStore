import pytest
from django.urls import reverse
from django.core.files.uploadedfile import SimpleUploadedFile
from rest_framework import status
from rest_framework.test import APIClient
from django.contrib.auth import get_user_model
from unittest.mock import patch, MagicMock

UserModel = get_user_model()

@pytest.mark.django_db
class TestUserAvatarPUT:
    @patch('cloudinary.uploader.destroy')
    @patch('cloudinary.uploader.upload_resource')
    def test_user_avatar_put(self, mock_upload, mock_destroy):
        """
        Test updating user avatar via PUT request.
        """
        # 1. Setup Mock
        mock_upload.return_value = 'test_avatar_id'
        
        # 2. Setup User & Client
        user = UserModel.objects.create_user(
            email="user@test.com",
            password="Password123!"
        )
        client = APIClient()
        client.force_authenticate(user=user)
        
        # 3. Prepare File
        image_content = b'\x47\x49\x46\x38\x39\x61\x01\x00\x01\x00\x80\x00\x00\x05\x04\x04\x00\x00\x00\x2c\x00\x00\x00\x00\x01\x00\x01\x00\x00\x02\x02\x44\x01\x00\x3b'
        uploaded_file = SimpleUploadedFile(
            name='avatar.gif',
            content=image_content,
            content_type='image/gif'
        )
        
        # 4. Perform PUT request
        # Endpoint: /api/users/avatars
        url = reverse('avatar')
        response = client.put(url, {'avatar': uploaded_file}, format='multipart')
        
        # 5. Assertions
        assert response.status_code == status.HTTP_200_OK
        
        # Refresh user from DB
        user.refresh_from_db()
        assert user.avatar is not None
        assert str(user.avatar) != ""
        
        assert mock_upload.called

    @patch('cloudinary.uploader.destroy')
    @patch('cloudinary.uploader.upload_resource')
    def test_user_avatar_replace_put(self, mock_upload, mock_destroy):
        """
        Test that old avatar is destroyed when a new one is uploaded.
        """
        # 1. Setup Mock
        mock_upload.return_value = 'new_avatar_id'
        
        # 2. Setup User
        user = UserModel.objects.create_user(
            email="user_replace@test.com",
            password="Password123!"
        )
        # Use a string that looks like a public_id
        # We need to mock the view's get_object or the user's avatar attribute
        # during the request execution.
        
        client = APIClient()
        client.force_authenticate(user=user)
        
        # 3. Prepare File
        image_content = b'\x47\x49\x46\x38\x39\x61\x01\x00\x01\x00\x80\x00\x00\x05\x04\x04\x00\x00\x00\x2c\x00\x00\x00\x00\x01\x00\x01\x00\x00\x02\x02\x44\x01\x00\x3b'
        uploaded_file = SimpleUploadedFile(
            name='new_avatar.gif',
            content=image_content,
            content_type='image/gif'
        )
        
        # 4. Perform PUT request with patching the user instance's avatar
        with patch('apps.users.views.AddProfileAvatarView.get_object') as mock_get_object:
            mock_user = MagicMock(spec=UserModel)
            mock_user.avatar.public_id = "old_avatar_id"
            mock_get_object.return_value = mock_user
            
            url = reverse('avatar')
            response = client.put(url, {'avatar': uploaded_file}, format='multipart')
        
        # 5. Assertions
        assert response.status_code == status.HTTP_200_OK
        assert mock_destroy.called_with("old_avatar_id")
        assert mock_upload.called
