from django.http import JsonResponse


def healthcheck(request):
    return JsonResponse({'status': 'Deployment is ready & API is working!'})

