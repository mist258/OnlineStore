from django.utils.deprecation import MiddlewareMixin


class DisableOpenerPolicyMiddleware(MiddlewareMixin):
    '''
        middleware that disable COOP/COEP only for OAuth via Google
    '''
    def process_request(self, request, response):

        if request.path.startswith("/api/auth_google/callback") or request.path.startswith("/oauth_google/callback"):
            response.headers["Cross-Origin-Opener-Policy"] = "unsafe_none"
            response.headers["Cross-Origin-Embedded-Policy"] = "unsafe_none"
        return response