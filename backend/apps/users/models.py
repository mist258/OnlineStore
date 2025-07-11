from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.core import validators as V
from django.db import models
from django.utils.translation import gettext_lazy as _

from core.models import BaseModel

from django_countries.fields import CountryField

from .managers import UserManager
from .regex.user_validation_regex import UserValidationRegex


class UserModel(AbstractBaseUser, PermissionsMixin, BaseModel):

    class Meta:
        db_table = "auth_user"
        ordering = ("id",)

    email = models.EmailField(_("Enter your email"), max_length=30 ,unique=True)
    is_superuser = models.BooleanField(default=False)
    subscription_updates_news = models.BooleanField(default=False)

    USERNAME_FIELD = "email"
    objects = UserManager()


class UserProfileModel(BaseModel):

    class Meta:
        db_table = "user_profile"
        ordering = ("id",)

    first_name = models.CharField(max_length=25, validators=[V.RegexValidator
                                                             (UserValidationRegex.NAME.pattern,
                                                              UserValidationRegex.NAME.msg)
                                                             ])
    last_name = models.CharField(max_length=25, validators=[V.RegexValidator
                                                            (UserValidationRegex.NAME.pattern,
                                                             UserValidationRegex.NAME.msg)
                                                            ])
    company_name = models.CharField(max_length=25, null=True, blank=True)
    country = CountryField(blank_label=_("Enter your country's name"))
    state = models.CharField(max_length=25)
    region = models.CharField(max_length=25)
    street_address = models.TextField(max_length=30)
    apartment_address = models.TextField(max_length=30)
    zip_code = models.CharField(max_length=15, validators=[V.RegexValidator
                                                           (UserValidationRegex.ZIP_CODE.pattern,
                                                            UserValidationRegex.ZIP_CODE.msg)
                                                           ])
    phone_number = models.CharField(max_length=15, validators=[V.RegexValidator
                                                               (UserValidationRegex.PHONE.pattern,
                                                                UserValidationRegex.PHONE.msg)
                                                               ], unique=True)
    user = models.OneToOneField(
        UserModel, on_delete=models.CASCADE, related_name="profile"
    )

