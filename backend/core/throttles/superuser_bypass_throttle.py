from rest_framework.throttling import UserRateThrottle


class SuperuserBypassThrottle(UserRateThrottle):
    scope = "user"

    def allow_request(self, request, view):

        user = request.user

        if user and user.is_staff and request.user.is_active and user.is_superuser:
            return True

        return super().allow_request(request, view)
