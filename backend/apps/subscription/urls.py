from django.urls import path

from .views import SubscribeUserForUpdateView, UnsubscribeUserFromUpdateView

urlpatterns = [
    path('', SubscribeUserForUpdateView.as_view()),
    path('/undone', UnsubscribeUserFromUpdateView.as_view()),

]
