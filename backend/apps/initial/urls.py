from django.urls import path

from .views import InitialTestView

urlpatterns = [
    path('', InitialTestView.as_view(), name='initial_test'),

]