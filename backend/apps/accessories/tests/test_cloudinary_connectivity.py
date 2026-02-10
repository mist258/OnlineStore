import pytest
import os
from django.core.files.uploadedfile import SimpleUploadedFile
from apps.accessories.models import Accessory, AccessoryPhotosModel

@pytest.mark.django_db
def test_real_cloudinary_upload_connectivity():
    """
    INTEGRATION TEST: Performs a real upload to Cloudinary.
    This verifies that CLOUD_NAME, API_KEY, and API_SECRET are valid.
    """
    # 1. Verify credentials are loaded
    cloud_name = os.environ.get("CLOUD_NAME")
    # Skip if we are in environment without real credentials or placeholder values
    if not cloud_name or cloud_name in ["your_cloud_name", "test"]:
        pytest.skip(f"Cloudinary credentials are not set for real test (CLOUD_NAME={cloud_name}).")

    # 2. Create parent model
    accessory = Accessory.objects.create(
        sku="CONN-TEST-002",
        name="Connectivity Test Real",
        price="0.99",
        quantity=1
    )

    # 3. Create a tiny valid GIF image
    image_content = b'\x47\x49\x46\x38\x39\x61\x01\x00\x01\x00\x80\x00\x00\x05\x04\x04\x00\x00\x00\x2c\x00\x00\x00\x00\x01\x00\x01\x00\x00\x02\x02\x44\x01\x00\x3b'
    uploaded_file = SimpleUploadedFile(
        name='connection_check.gif',
        content=image_content,
        content_type='image/gif'
    )

    # 4. Action: Trigger real upload
    try:
        photo_instance = AccessoryPhotosModel.objects.create(
            accessory=accessory,
            photo=uploaded_file
        )
        
        # 5. Assertions
        assert photo_instance.photo is not None
        url = photo_instance.photo.url
        print(f"\n[SUCCESS] Cloudinary URL generated: {url}")
        
        # Verify the URL points to Cloudinary
        assert "res.cloudinary.com" in url or cloud_name in url
        
    except Exception as e:
        pytest.fail(f"Cloudinary upload failed! Check your credentials and network. Error: {e}")
    
    finally:
        # Cleanup: Remove from DB
        accessory.delete()
