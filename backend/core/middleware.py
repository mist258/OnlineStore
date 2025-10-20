

class DisableOpenerPolicyMiddleware:
    '''
        middleware that disable COOP/COEP only for OAuth via Google
    '''

    def __init__(self, get_response):
        self.get_response = get_response
    
    def __call__(self, request):
        response = self.get_response(request)
        if request.path.startswith("/api/auth_google/callback"):
            response.headers["Cross-Origin-Opener-Policy"] = "unsafe_none"
            response.headers["Cross-Origin-Embedded-Policy"] = "unsafe_none"
        return response
