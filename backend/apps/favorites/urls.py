from django.urls import path
from apps.favorites.views import (
    FavoritesView,
    ToggleFavoriteView,
    CheckFavoriteView,
    FavoritesCountView,
)

urlpatterns = [
    path("", FavoritesView.as_view(), name="favorites-list"),
    path("/count/", FavoritesCountView.as_view(), name="favorites-count"),
    path("/<str:item_type>/<int:item_id>/toggle/", ToggleFavoriteView.as_view(), name="favorites-toggle"),
    path("/<str:item_type>/<int:item_id>/check/", CheckFavoriteView.as_view(), name="favorites-check"),
]
