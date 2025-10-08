"""
URL configuration for configs project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path

from rest_framework.permissions import AllowAny

from drf_yasg import openapi
from drf_yasg.views import get_schema_view

schema_view = get_schema_view(
    openapi.Info(
        title="Online store",
        default_version="v1",
        description="Online coffee store",
        contact=openapi.Contact(email="admin@gmai.com"),
        license=openapi.License(name="MIT License"),
    ),
    public=True,
    permission_classes=[AllowAny],
)
urlpatterns = [
    path("api/products", include("apps.products.urls")),
    path("api/reviev", include("apps.reviews.urls")),
    path("api/supplies", include("apps.supplies.urls")),
    path("api/services", include("apps.subscription.urls")),
    path("api/orders", include("apps.orders.urls")),
    path("api/basket", include("apps.basket.urls")),
    path("api/favorites", include("apps.favorites.urls")),
    path("api/discount-codes", include("apps.discount_codes.urls")),
    path("api/users", include("apps.users.urls")),
    path("api/auth", include("apps.auth.urls")),
    path("api/auth_google", include("apps.oauth_google.urls")),
    path("api/accessories", include("apps.accessories.urls")),
    path("api/search", include("apps.search.urls")),
    path("api/doc", schema_view.with_ui("swagger", cache_timeout=0), name="schema-swagger",
    ),
    path("admin/", admin.site.urls),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)