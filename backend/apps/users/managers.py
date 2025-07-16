from django.contrib.auth.models import UserManager as Manager


class UserManager(Manager):
    def create_user(self, email=None, password=None, **extra_fields):
        extra_fields.setdefault("subscription_updates_news", False)

        if extra_fields["subscription_updates_news"] is not False:
            raise ValueError("Cannot create user with subscription_updates_news=True")

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

        if extra_fields["is_superuser"] is not True:
            raise ValueError("User must have is_superuser=True")

        user = self.create_user(email, password, **extra_fields)
        return user
