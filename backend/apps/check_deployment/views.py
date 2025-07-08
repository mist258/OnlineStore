from django.http import JsonResponse
from django.views import View


class CheckDeploymentView(View):
    def get(self, request):
        return JsonResponse({"status": "API is running"})
