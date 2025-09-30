from django.urls import include, path

from rest_framework.routers import DefaultRouter

from .views import GlobalItemSearchView

router = DefaultRouter()
router.register(r'items', GlobalItemSearchView, basename='global_search')

urlpatterns = [
    path('/', include(router.urls)),

]