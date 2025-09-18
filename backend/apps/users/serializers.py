import re

from django.contrib.auth import get_user_model
from django.db.transaction import atomic

from rest_framework import serializers
from rest_framework.exceptions import ValidationError

from apps.orders.serializers import OrderReadSerializer

from core.services.email_service import EmailService

from .models import UserProfileModel

UserModel = get_user_model()


class UserProfileSerializer(serializers.ModelSerializer):
    """
        Serializer for user profile
    """
    class Meta:
        model = UserProfileModel
        fields = (
            "id",
            "first_name",
            "last_name",
            "company_name",
            "country",
            "state",
            "region",
            "street_name",
            "apartment_number",
            "zip_code",
            "phone_number",
        )


class UserSerializer(serializers.ModelSerializer):
    """
        Serializer for creating new users
    """
    profile = UserProfileSerializer()

    class Meta:
        model = UserModel
        fields = (
            "id",
            "avatar",
            "email",
            "password",
            "is_superuser",
            "is_staff",
            "is_active",
            "subscription_updates_news",
            "last_login",
            "created_at",
            "updated_at",
            "profile",
        )

        extra_kwargs = {
            "password":
                {
                    "write_only": True
                }
        }

        read_only_fields = (
            "id",
            "is_superuser",
            "is_staff",
            "is_active",
            "subscription_updates_news",
            "last_login",
            "created_at",
            "updated_at",
        )

    @atomic
    def create(self, validated_data: dict):
        profile = validated_data.pop("profile")
        user = UserModel.objects.create_user(**validated_data)
        UserProfileModel.objects.create(**profile, user=user)
        #EmailService.greeting_registration_email(user)
        return user

    def validate(self, attrs):
        password = attrs.get("password")

        pattern = r"^[A-Za-z\d@$!%*?&]{8,}$"

        if not re.fullmatch(pattern, password):
            raise ValidationError('Password must contain at least 8 characters, '
                                  '1 special symbol, 1 letter, 1 number')
        return attrs


class UpdateUserInfoSerializer(serializers.ModelSerializer):
    """
        serializer for updating user info
    """
    profile = UserProfileSerializer()

    class Meta:
        model = UserModel
        fields = ("email",
                  "profile",
                  )

    def update(self, instance, validated_data):
        profile_data = validated_data.pop("profile", None)

        for key, value in validated_data.items():
            setattr(instance, key, value)
        instance.save()

        if profile_data:
            profile = instance.profile
            for key, value in profile_data.items():
                setattr(profile, key, value)
            profile.save()
        #EmailService.updated_info_notification_email(instance)
        return instance


class UserAvatarSerializer(serializers.ModelSerializer):
    """
        serializer for uploading avatar to user profile
    """
    class Meta:
        model = UserModel
        fields = ("avatar",)

class UserOwnProfileInformationSerializer(serializers.ModelSerializer):
    """
        for the user to view their own account information
        and created orders
    """
    profile = UserProfileSerializer(read_only=True)
    orders = OrderReadSerializer(many=True, read_only=True)

    class Meta:
        model = UserModel
        fields = (
            "email",
            "profile",
            "orders",
        )
