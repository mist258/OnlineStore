import re

from django.contrib.auth import get_user_model
from django.db.transaction import atomic

from rest_framework import serializers
from rest_framework.exceptions import ValidationError

from core.services.email_service import EmailService

from .models import UserProfileModel

UserModel = get_user_model()


class UserProfileSerializer(serializers.ModelSerializer):
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
    profile = UserProfileSerializer()

    class Meta:
        model = UserModel
        fields = (
            "id",
            "email",
            "password",
            "is_superuser",
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
        EmailService.greeting_registration_email(user)
        return user

    def validate(self, attrs):
        password = attrs.get("password")

        pattern = r"^[A-Za-z\d@$!%*?&]{8,}$"

        if not re.fullmatch(pattern, password):
            raise ValidationError('Password must contain at least 8 characters, '
                                  '1 special symbol, 1 letter, 1 number')
        return attrs

