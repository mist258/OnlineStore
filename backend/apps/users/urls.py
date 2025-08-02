from django.urls import include, path

from rest_framework.routers import DefaultRouter

from .views import CreateUserView, DeleteUserView, GetMyInfoView, ListUsersView

router = DefaultRouter()
router.register(r"list", ListUsersView, basename="users_list")
urlpatterns = [
    path("/", include(router.urls)),
    path("/registration",
         CreateUserView.as_view(), name="register_user"
         ), # register new user
    path(
        "/info", GetMyInfoView.as_view(), name="get_own_info"
    ), # get own info
    path(
        "/<int:pk>", DeleteUserView.as_view(), name="destroy_user"
    ), # delete user



]
