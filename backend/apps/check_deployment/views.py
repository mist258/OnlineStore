from django.http import JsonResponse
from django.views import View


class HealthcheckView(View):
    def get(self, request, *args, **kwargs):
        return JsonResponse({'status': 'Deployment is running'})

