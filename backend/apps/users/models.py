from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.core import validators as V
from django.db import models
from django.utils.translation import gettext_lazy as _

from core.models import BaseModel
from core.services.photo_service import PhotoService

from phonenumber_field.modelfields import PhoneNumberField

from.managers import UserManager, UserProfileManager

from .regex.user_validation_regex import UserValidationRegex


class UserModel(AbstractBaseUser, PermissionsMixin, BaseModel):
    class Meta:
        db_table = "auth_user"
        ordering = ("id",)

    email = models.EmailField(_("Enter your email"), max_length=50, unique=True, db_index=True)
    avatar = models.ImageField(upload_to=PhotoService.upload_avatar, blank=True)
    is_superuser = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    subscription_updates_news = models.BooleanField(default=False)
    
    USERNAME_FIELD = "email"
    objects = UserManager()


class UserProfileModel(BaseModel):

    class Meta:
        db_table = "user_profile"
        ordering = ("id",)

    first_name = models.CharField(
        max_length=25,
        validators=[
            V.RegexValidator(
                UserValidationRegex.NAME.pattern, UserValidationRegex.NAME.msg
            )
        ],
    )
    last_name = models.CharField(
        max_length=25,
        validators=[
            V.RegexValidator(
                UserValidationRegex.NAME.pattern, UserValidationRegex.NAME.msg
            )
        ],
    )
    company_name = models.CharField(max_length=25, null=True, blank=True)
    country = models.CharField(max_length=25, null=True, blank=True)
    state = models.CharField(max_length=25, null=True, blank=True)
    region = models.CharField(max_length=25, null=True, blank=True)
    street_name = models.TextField(max_length=30, null=True, blank=True)
    apartment_number = models.TextField(max_length=30, null=True, blank=True)
    zip_code = models.CharField(
        max_length=15,
        validators=[
            V.RegexValidator(
                UserValidationRegex.ZIP_CODE.pattern, UserValidationRegex.ZIP_CODE.msg
            )
        ],
        null=True, blank=True,
    )
    phone_number = PhoneNumberField(null=True, blank=True)
    user = models.OneToOneField(
        UserModel, 
        on_delete=models.CASCADE, 
        related_name="profile",
        null=True,
        blank=True
    )

    objects = UserProfileManager()

