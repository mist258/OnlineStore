from typing import List

from django.db.models import Q
from django.shortcuts import get_object_or_404

from apps.products.models import Accessory
from apps.products.serializers import AccessorySerializer


class AccessoryService:
    @staticmethod
    def get_accessories(
        search: str = None,
        category: str = None,
        brand: str = None,
        min_price: float = None,
        max_price: float = None
    ) -> List[Accessory]:
        """
        Get accessories with optional filtering
        """
        queryset = Accessory.objects.all()

        if search:
            queryset = queryset.filter(
                Q(name__icontains=search) |
                Q(description__icontains=search)
            )

        if category:
            queryset = queryset.filter(category__iexact=category)

        if brand:
            queryset = queryset.filter(brand__iexact=brand)

        if min_price is not None:
            queryset = queryset.filter(price__gte=min_price)

        if max_price is not None:
            queryset = queryset.filter(price__lte=max_price)

        return queryset

    @staticmethod
    def get_accessory_by_id(accessory_id: int) -> Accessory:
        """
        Get a single accessory by ID
        """
        return get_object_or_404(Accessory, id=accessory_id)

    @staticmethod
    def create_accessory(data: dict) -> Accessory:
        """
        Create a new accessory
        """
        serializer = AccessorySerializer(data=data)
        serializer.is_valid(raise_exception=True)
        return serializer.save()

    @staticmethod
    def update_accessory(accessory_id: int, data: dict) -> Accessory:
        """
        Update an existing accessory
        """
        accessory = get_object_or_404(Accessory, id=accessory_id)
        serializer = AccessorySerializer(accessory, data=data, partial=True)
        serializer.is_valid(raise_exception=True)
        return serializer.save()

    @staticmethod
    def delete_accessory(accessory_id: int) -> None:
        """
        Delete an accessory
        """
        accessory = get_object_or_404(Accessory, id=accessory_id)
        accessory.delete()
