from django.urls import path

from .views import GlobalItemSearchView

urlpatterns = [
    path('/items/', GlobalItemSearchView.as_view({'get': 'list'}), name='global_search_items'),

]