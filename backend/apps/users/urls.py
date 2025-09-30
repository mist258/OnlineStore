from django.urls import include, path

from rest_framework.routers import DefaultRouter

from .views import (
    AddProfileAvatarView,
    CreateUserView,
    DeleteUserView,
    GetProfileInfoView,
    ListUsersView,
    UpdateUsersInfoView,
    UserInfoForAutofillOrdersForm,
)

router = DefaultRouter()
router.register(r"list", ListUsersView, basename="users_list")
urlpatterns = [
    path(
        "/", include(router.urls)
    ), # list all users or user by id
    path("/registration",
         CreateUserView.as_view(), name="register_user"
         ), # register new user
    path(
        "/info", GetProfileInfoView.as_view(), name="get_own_info"
    ), # get own info
    path(
        "/<int:pk>", DeleteUserView.as_view(), name="destroy_user"
    ), # delete user
    path(
        "/update", UpdateUsersInfoView.as_view(), name="update_user_info"
    ), # users can update own info
    path(
        "/autofill_form", UserInfoForAutofillOrdersForm.as_view(), name="autofill_form"
    ), # this view can be used to autofill form when user will place an order
    path(
        "/avatars", AddProfileAvatarView.as_view(), name="avatar"
    ) # user can add photo

]
