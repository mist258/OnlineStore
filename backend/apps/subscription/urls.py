from django.urls import path

from .views import SubscribeUserForUpdateView, UnsubscribeUserFromUpdateView

urlpatterns = [
    path('/subscribe', SubscribeUserForUpdateView.as_view()),
    path('/unsubscribe', UnsubscribeUserFromUpdateView.as_view()),
    
]
