REST_FRAMEWORK = {
    "DEFAULT_RENDERER_CLASSES": [
        "rest_framework.renderers.JSONRenderer",
    ],

    "DEFAULT_FILTER_BACKENDS": [
        "django_filters.rest_framework.DjangoFilterBackend"
    ],

    "DEFAULT_PAGINATION_CLASS": "core.pagination.PagePagination",

    "DEFAULT_AUTHENTICATION_CLASSES": (
        "rest_framework_simplejwt.authentication.JWTAuthentication",
    ),

    "DEFAULT_PERMISSION_CLASSES": [
        "core.permissions.is_super_user_permission.IsSuperUser",
    ],

    "EXCEPTION_HANDLER": "core.handlers.error_handler.error_handler",

    "DEFAULT_THROTTLE_CLASSES": [
        "core.throttles.superuser_bypass_throttle.SuperuserBypassThrottle",
        "core.throttles.sustained_burst_throttle.UserSustainedRateThrottle",
        "core.throttles.sustained_burst_throttle.UserBurstRateThrottle",
        "core.throttles.sustained_burst_throttle.AnonSustainedRateThrottle",
        "core.throttles.sustained_burst_throttle.AnonBurstRateThrottle",
    ],

    "DEFAULT_THROTTLE_RATES": {
        "user_sustained": "1000/day",
        "user_burst": "70/min",
        "anon_sustained": "700/day",
        "anon_burst": "40/min",
    }
}

