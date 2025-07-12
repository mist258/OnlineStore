from django.contrib.auth import get_user_model
from django.contrib.auth.models import AbstractBaseUser

from rest_framework.permissions import BasePermission

UserModel: type[AbstractBaseUser] = get_user_model()

class IsSuperUser(BasePermission):
    def has_permission(self, request, view):
        return bool(request.user and request.user.is_superuser)
