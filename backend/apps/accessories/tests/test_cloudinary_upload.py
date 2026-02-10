import pytest
from unittest.mock import patch, MagicMock
from django.core.files.uploadedfile import SimpleUploadedFile
from apps.accessories.models import Accessory, AccessoryPhotosModel

@pytest.mark.django_db
@patch('cloudinary.uploader.upload_resource')
def test_accessory_photo_upload_field(mock_upload):
    """
    Verify that AccessoryPhotosModel can be created with a photo 
    and is correctly linked to an Accessory.
    """
    # Configure mock to return a dummy string (public_id)
    mock_upload.return_value = 'test_public_id'

    # 1. Create a parent Accessory
    accessory = Accessory.objects.create(
        sku="TEST-SKU-001",
        name="Test Accessory",
        price="10.00",
        quantity=5
    )

    # 2. Create a dummy image
    image_content = b'\x47\x49\x46\x38\x39\x61\x01\x00\x01\x00\x80\x00\x00\x05\x04\x04\x00\x00\x00\x2c\x00\x00\x00\x00\x01\x00\x01\x00\x00\x02\x02\x44\x01\x00\x3b'
    uploaded_file = SimpleUploadedFile(
        name='test_image.gif',
        content=image_content,
        content_type='image/gif'
    )

    # 3. Create the Photo Model instance
    photo_instance = AccessoryPhotosModel.objects.create(
        accessory=accessory,
        photo=uploaded_file
    )

    # 4. Assertions
    assert photo_instance.id is not None
    assert photo_instance.accessory == accessory
    # Check that the photo field has a value
    assert photo_instance.photo is not None
    assert str(photo_instance.photo) != ""
    assert mock_upload.called
