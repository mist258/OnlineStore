from django.urls import path

from .views import CreateUserView, GetMyInfoView, ListAllUsersView

urlpatterns = [
    path("",
         CreateUserView.as_view(), name="register_user"
         ), # register new user
    path(
        "/info", GetMyInfoView.as_view(), name="get_own_info"
    ), # get own info
    path("/users_list", ListAllUsersView.as_view(), name="users_list")

]
