from django.contrib.auth.models import UserManager as Manager
from django.db import models


class UserManager(Manager):

    def create_user(self, email=None, password=None, **extra_fields):

        if not email:
            raise ValueError("Email required")

        if not password:
            raise ValueError("Password required")

        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, email=None, password=None, **extra_fields):
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_active", True)

        if extra_fields["is_superuser"] is not True:
            raise ValueError("User must have is_superuser=True")
        if extra_fields["is_staff"] is not True:
            raise ValueError("User must have is_staff=True")
        if extra_fields["is_active"] is not True:
            raise ValueError("User must have is_active=True")

        user = self.create_user(email, password, **extra_fields)
        return user
    
    def check_and_create_anonymous_user(self, email):
        """
        Try to find anonymous user email or create if not exists.
        """
        anonymous_user, created = self.get_or_create(
            email=email,
            defaults={
                "is_active": False,
                "is_staff": False,
                "is_superuser": False,
            }
        )
        return anonymous_user

class UserProfileManager(models.Manager):

    def create_snapshot_profile(self, source):
        """
        Create a snapshot profile either from dict (billing_details)
        or from an existing UserProfile instance.
        """

        if isinstance(source, dict):
            fields = {
                "first_name": source.get("first_name", ""),
                "last_name": source.get("last_name", ""),
                "company_name": source.get("company_name", ""),
                "country": source.get("country", ""),
                "state": source.get("state", ""),
                "region": source.get("region", ""),
                "street_name": source.get("street_name", ""),
                "apartment_number": source.get("apartment_number", ""),
                "zip_code": source.get("zip_code", ""),
                "phone_number": source.get("phone_number", ""),
            }
        else:
            fields = {
                "first_name": source.first_name,
                "last_name": source.last_name,
                "company_name": source.company_name,
                "country": source.country,
                "state": source.state,
                "region": source.region,
                "street_name": source.street_name,
                "apartment_number": source.apartment_number,
                "zip_code": source.zip_code,
                "phone_number": source.phone_number,
            }

        snapshot = self.model(user=None, **fields)
        snapshot.save()
        return snapshot
