from rest_framework.throttling import BaseThrottle


class SuperuserBypassThrottle(BaseThrottle):
    def allow_request(self, request, view):
        pass
