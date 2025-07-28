from rest_framework.throttling import AnonRateThrottle, UserRateThrottle


# long-term restrictions for users
class UserSustainedRateThrottle(UserRateThrottle):
    scope = "user_sustained"

# short-term restrictions for users
class UserBurstRateThrottle(UserRateThrottle):
    scope = "user_burst"

# long-term restrictions for anonymous
class AnonSustainedRateThrottle(AnonRateThrottle):
    scope = "anon_sustained"

# short-term restrictions for anonymous
class AnonBurstRateThrottle(AnonRateThrottle):
    scope = "anon_burst"