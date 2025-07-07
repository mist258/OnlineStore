from django.urls import path

from .views import InitialAddPhotoView, InitialTestView

urlpatterns = [
    path('', InitialTestView.as_view(), name='initial_test'),
    path('/<int:pk>/photo', InitialAddPhotoView.as_view(), name='initial_add_photo'),

]