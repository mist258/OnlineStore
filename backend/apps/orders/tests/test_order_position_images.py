"""
Tests for order position image serialization.

Tests verify that product and accessory images are correctly serialized
in order positions, ensuring proper data structure and multiple images support.
"""
from django.urls import reverse

from rest_framework import status

from apps.orders.models import OrderPosition
from apps.orders.serializers import OrderPositionReadSerializer

import pytest


@pytest.mark.django_db
class TestOrderPositionImagesProduct:
    """Test image serialization for order positions with products"""

    def test_order_position_product_with_single_image(
        self, product, product_photo, order_position_with_product
    ):
        """Test that a single product image is correctly serialized"""
        serializer = OrderPositionReadSerializer(order_position_with_product)
        data = serializer.data

        assert data["product"] is not None
        assert data["accessory"] is None
        assert "images" in data["product"]
        assert isinstance(data["product"]["images"], list)
        assert len(data["product"]["images"]) == 1
        assert data["product"]["images"][0]["url"] == "https://example.com/product-image-1.jpg"

    def test_order_position_product_with_multiple_images(
        self, product, product_photos, order_position_with_product
    ):
        """Test that multiple product images are correctly serialized"""
        serializer = OrderPositionReadSerializer(order_position_with_product)
        data = serializer.data

        assert data["product"] is not None
        assert "images" in data["product"]
        assert isinstance(data["product"]["images"], list)
        assert len(data["product"]["images"]) == 3

        # Verify all image URLs are present
        image_urls = [img["url"] for img in data["product"]["images"]]
        expected_urls = [
            "https://example.com/product-image-1.jpg",
            "https://example.com/product-image-2.jpg",
            "https://example.com/product-image-3.jpg",
        ]
        assert sorted(image_urls) == sorted(expected_urls)

    def test_order_position_product_without_images(self, product, order_position_with_product):
        """Test order position with product but no images"""
        serializer = OrderPositionReadSerializer(order_position_with_product)
        data = serializer.data

        assert data["product"] is not None
        assert "images" in data["product"]
        assert isinstance(data["product"]["images"], list)
        assert len(data["product"]["images"]) == 0

    def test_order_position_product_contains_all_fields(
        self, product, product_photo, order_position_with_product
    ):
        """Test that product serialization includes all required fields"""
        serializer = OrderPositionReadSerializer(order_position_with_product)
        data = serializer.data

        product_data = data["product"]
        assert "id" in product_data
        assert "name" in product_data
        assert "price" in product_data
        assert "quantity" in product_data
        assert "images" in product_data
        assert "total_price" in product_data

        # Verify values
        assert product_data["id"] == product.id
        assert product_data["name"] == product.name
        assert product_data["quantity"] == 2
        assert float(product_data["price"]) == 100.0
        assert float(product_data["total_price"]) == 200.0


@pytest.mark.django_db
class TestOrderPositionImagesAccessory:
    """Test image serialization for order positions with accessories"""

    def test_order_position_accessory_with_single_image(
        self, accessory, accessory_photo, order_position_with_accessory
    ):
        """Test that a single accessory image is correctly serialized"""
        serializer = OrderPositionReadSerializer(order_position_with_accessory)
        data = serializer.data

        assert data["accessory"] is not None
        assert data["product"] is None
        assert "images" in data["accessory"]
        assert isinstance(data["accessory"]["images"], list)
        assert len(data["accessory"]["images"]) == 1
        assert data["accessory"]["images"][0]["url"] == "https://example.com/accessory-image-1.jpg"

    def test_order_position_accessory_with_multiple_images(
        self, accessory, accessory_photos, order_position_with_accessory
    ):
        """Test that multiple accessory images are correctly serialized"""
        serializer = OrderPositionReadSerializer(order_position_with_accessory)
        data = serializer.data

        assert data["accessory"] is not None
        assert "images" in data["accessory"]
        assert isinstance(data["accessory"]["images"], list)
        assert len(data["accessory"]["images"]) == 3

        # Verify all image URLs are present
        image_urls = [img["url"] for img in data["accessory"]["images"]]
        expected_urls = [
            "https://example.com/accessory-image-1.jpg",
            "https://example.com/accessory-image-2.jpg",
            "https://example.com/accessory-image-3.jpg",
        ]
        assert sorted(image_urls) == sorted(expected_urls)

    def test_order_position_accessory_without_images(
        self, accessory, order_position_with_accessory
    ):
        """Test order position with accessory but no images"""
        serializer = OrderPositionReadSerializer(order_position_with_accessory)
        data = serializer.data

        assert data["accessory"] is not None
        assert "images" in data["accessory"]
        assert isinstance(data["accessory"]["images"], list)
        assert len(data["accessory"]["images"]) == 0

    def test_order_position_accessory_contains_all_fields(
        self, accessory, accessory_photo, order_position_with_accessory
    ):
        """Test that accessory serialization includes all required fields"""
        serializer = OrderPositionReadSerializer(order_position_with_accessory)
        data = serializer.data

        accessory_data = data["accessory"]
        assert "id" in accessory_data
        assert "name" in accessory_data
        assert "price" in accessory_data
        assert "quantity" in accessory_data
        assert "images" in accessory_data
        assert "total_price" in accessory_data

        # Verify values
        assert accessory_data["id"] == accessory.id
        assert accessory_data["name"] == accessory.name
        assert accessory_data["quantity"] == 1
        assert float(accessory_data["price"]) == 29.99
        assert float(accessory_data["total_price"]) == 29.99


@pytest.mark.django_db
class TestOrderPositionImagesAPI:
    """Test image serialization through API endpoints"""

    def test_get_order_detail_with_product_images(
        self, api_client, user, order, product, product_photos, order_position_with_product
    ):
        """Test that order detail endpoint returns product images correctly"""
        api_client.force_authenticate(user=user)
        url = reverse("orders:details_order", kwargs={"pk": order.id})

        response = api_client.get(url)

        assert response.status_code == status.HTTP_200_OK
        assert len(response.data["positions"]) == 1

        position = response.data["positions"][0]
        assert position["product"] is not None
        assert "images" in position["product"]
        assert len(position["product"]["images"]) == 3

    def test_get_order_detail_with_accessory_images(
        self, api_client, user, order, accessory, accessory_photos, order_position_with_accessory
    ):
        """Test that order detail endpoint returns accessory images correctly"""
        api_client.force_authenticate(user=user)
        url = reverse("orders:details_order", kwargs={"pk": order.id})

        response = api_client.get(url)

        assert response.status_code == status.HTTP_200_OK
        assert len(response.data["positions"]) == 1

        position = response.data["positions"][0]
        assert position["accessory"] is not None
        assert "images" in position["accessory"]
        assert len(position["accessory"]["images"]) == 3

    def test_get_order_list_with_images(
        self, api_client, user, order, product, product_photo, order_position_with_product
    ):
        """Test that order list endpoint returns images in positions"""
        api_client.force_authenticate(user=user)
        url = reverse("orders:user_orders")

        response = api_client.get(url)

        assert response.status_code == status.HTTP_200_OK
        
        # Response is paginated, so data is under "data" key
        orders_list = response.data.get("data", response.data)
        assert len(orders_list) > 0

        # Find our order in the list
        order_data = next((o for o in orders_list if o["id"] == order.id), None)
        assert order_data is not None
        assert len(order_data["positions"]) == 1

        position = order_data["positions"][0]
        assert position["product"] is not None
        assert "images" in position["product"]
        assert len(position["product"]["images"]) == 1


@pytest.mark.django_db
class TestOrderPositionImagesMixed:
    """Test order positions with mixed product and accessory items"""

    def test_order_with_both_product_and_accessory_positions(
        self,
        api_client,
        user,
        order,
        product,
        product_photos,
        accessory,
        accessory_photos,
        order_position_with_product,
        order_position_with_accessory,
    ):
        """Test order with both product and accessory positions have correct images"""
        api_client.force_authenticate(user=user)
        url = reverse("orders:details_order", kwargs={"pk": order.id})

        response = api_client.get(url)

        assert response.status_code == status.HTTP_200_OK
        assert len(response.data["positions"]) == 2

        # Check product position
        product_position = next(
            (p for p in response.data["positions"] if p["product"] is not None), None
        )
        assert product_position is not None
        assert len(product_position["product"]["images"]) == 3

        # Check accessory position
        accessory_position = next(
            (p for p in response.data["positions"] if p["accessory"] is not None), None
        )
        assert accessory_position is not None
        assert len(accessory_position["accessory"]["images"]) == 3

    def test_images_are_json_serializable(
        self, product, product_photos, order_position_with_product
    ):
        """Test that images field is properly JSON serializable"""
        import json

        serializer = OrderPositionReadSerializer(order_position_with_product)
        data = serializer.data

        # This should not raise an exception
        json_string = json.dumps(data)
        parsed = json.loads(json_string)

        assert "images" in parsed["product"]
        assert isinstance(parsed["product"]["images"], list)
        assert len(parsed["product"]["images"]) == 3
