from django.db.transaction import atomic

from rest_framework import serializers

from apps.products.models import Photo, PhotosModel, Product
from apps.supplies.models import Supply
from apps.supplies.serializers import SupplySerializer

from .models import FlavorProfile


class FlavourProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = FlavorProfile
        fields = ("id",
                  "name")


class PhotoSerializer(serializers.ModelSerializer):
    """
        serializer that allows add photos to a product via url
    """

    class Meta:
        model = Photo
        fields = ("id",
                  "url",
                  "position",)


class ProductPhotoSerializer(serializers.ModelSerializer):
    """"
        serializer that allows to add photos to a product by uploading file from local machine
    """

    class Meta:
        model = PhotosModel
        fields = ("id",
                  "photo",)


class ProductSerializer(serializers.ModelSerializer):
    supplies = SupplySerializer(many=True)
    flavor_profiles = FlavourProfileSerializer(many=True)
    product_photos = ProductPhotoSerializer(read_only=True, many=True)
    photos_url = PhotoSerializer(read_only=True, many=True)

    class Meta:
        model = Product
        fields = ("id",
                  "sku",
                  "name",
                  "brand",
                  "caffeine_type",
                  "sort",
                  "roast",
                  "description",
                  "supplies",
                  "product_photos",
                  "photos_url",
                  "flavor_profiles",)

        read_only_fields = ("id",)

    @atomic
    def create(self, validated_data: dict) -> Product:
        supplies = validated_data.pop("supplies", [])
        flavor_profiles = validated_data.pop("flavor_profiles", [])
        product = Product.objects.create(**validated_data)

        for supply in supplies:
            Supply.objects.create(product=product, **supply)

        flavor_profile_instance = []
        for flavor_profile in flavor_profiles:
            obj, _ = FlavorProfile.objects.get_or_create(name=flavor_profile["name"])
            flavor_profile_instance.append(obj)

        product.flavor_profiles.set(flavor_profile_instance)

        return product

    @atomic
    def update(self, instance, validated_data: dict) -> Product:
        supplies = validated_data.pop("supplies", [])
        flavor_profiles = validated_data.pop("flavor_profiles", [])
        instance = super().update(instance, validated_data)

        if supplies:
            for item_supply in supplies:
                print(el for el in supplies)
                Supply.objects.update(**item_supply)

        if flavor_profiles:
            for item_flavor_profile in flavor_profiles:
                FlavorProfile.objects.update(**item_flavor_profile)

        instance.save()
        return instance