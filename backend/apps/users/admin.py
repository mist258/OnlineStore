from django.contrib import admin

from apps.users.models import UserModel, UserProfileModel

admin.site.register(UserModel)

admin.site.register(UserProfileModel)