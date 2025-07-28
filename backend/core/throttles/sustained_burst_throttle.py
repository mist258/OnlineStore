from rest_framework.throttling import AnonRateThrottle, UserRateThrottle


# long-term restrictions for anonymous
class AnonSustainedRateThrottle(AnonRateThrottle):
    scope = "anon_sustained"

# short-term restrictions for anonymous
class AnonBurstRateThrottle(AnonRateThrottle):
    scope = "anon_burst"
