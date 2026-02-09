from django.contrib.auth import get_user_model
from django.utils.decorators import method_decorator

from rest_framework import generics, status, viewsets
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response

import cloudinary.uploader
from drf_yasg.utils import swagger_auto_schema

from .serializers import UpdateUserInfoSerializer, UserAvatarSerializer, UserOwnProfileInformationSerializer, UserSerializer

UserModel = get_user_model()


@method_decorator(
    name="post",
    decorator=swagger_auto_schema(
        security=[],
        operation_id="register_new_user", responses={200: UserSerializer()}
    ),
)
class CreateUserView(generics.CreateAPIView):
    """
    register new user
    (allow for any users)
    """

    serializer_class = UserSerializer
    queryset = UserModel.objects.all()
    permission_classes = (AllowAny,)


@method_decorator(
    name="get",
    decorator=swagger_auto_schema(
        operation_id="get_own_info", responses={200: UserSerializer()}
    ),
)
class GetProfileInfoView(generics.GenericAPIView):
    """
        get own info about profile and orders
        (allow for authenticated users)
    """

    queryset = UserModel.objects.all()
    serializer_class = UserOwnProfileInformationSerializer
    permission_classes = (IsAuthenticated,)

    def get(self, *args, **kwargs):
        user = self.request.user

        if user.is_staff or user.is_superuser:
            serializer = UserSerializer(user)
            return Response(serializer.data,
                            status=status.HTTP_200_OK)

        serializer = UserOwnProfileInformationSerializer(user)
        return Response(serializer.data,
                        status.HTTP_200_OK)


@method_decorator(
    name="list",
    decorator=swagger_auto_schema(
        operation_id="get_users_info", responses={200: UserSerializer()}
    ),
)
class ListUsersView(viewsets.ReadOnlyModelViewSet):
    """
        /api/users/list/ - list all users
        /api/users/list/<int:pk>/ - list user by id
        (only for superuser)
    """

    queryset = UserModel.objects.all()
    serializer_class = UserSerializer
    permission_classes = (IsAuthenticated,)


@method_decorator(name="delete", decorator=swagger_auto_schema(
    operation_id="delete_user"
    ),
)
class DeleteUserView(generics.DestroyAPIView):
    """
        delete user
        (allow for superuser)
    """
    queryset = UserModel.objects.all()
    serializer_class = UserSerializer

    def delete(self, request, *args, **kwargs):
        user = self.get_object()
        user.delete()
        return Response({"Details": "User successfully deleted"},
                        status.HTTP_204_NO_CONTENT)


@method_decorator(name="patch", decorator=swagger_auto_schema(
    operation_id="update_user's_info",
    responses={200: UserSerializer()}
    ),
)
class UpdateUsersInfoView(generics.UpdateAPIView):
    """
        user can update own info
        (available for authenticated users)
    """
    serializer_class = UpdateUserInfoSerializer
    queryset = UserModel.objects.all()
    permission_classes = (IsAuthenticated,)
    allowed_methods = ("PATCH",)

    def patch(self, request, *args, **kwargs):
        user = self.request.user
        data = request.data
        serializer = self.serializer_class(user, data=data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status.HTTP_200_OK)


@method_decorator(name="get", decorator=swagger_auto_schema(
    operation_id="get_user_info_for_autofill_form",
    responses={200: UserSerializer()}
))
class UserInfoForAutofillOrdersForm(generics.GenericAPIView):
    """
        this info for autofilling form when user place an order
        (for authenticated users)
    """
    queryset = UserModel.objects.all()
    serializer_class = UserSerializer
    permission_classes = (IsAuthenticated,)

    def get(self, request, *args, **kwargs):
        user = self.request.user
        serializer = UserSerializer(user)
        return Response(serializer.data,
                        status.HTTP_200_OK)


@method_decorator(name="put", decorator=swagger_auto_schema(
    operation_id="add_photo_to_profile",
    responses={200: UserAvatarSerializer()}
))
class AddProfileAvatarView(generics.UpdateAPIView):
    """
        add avatar to user's profile
        (allow for authenticated users)
    """
    serializer_class = UserAvatarSerializer
    permission_classes = (IsAuthenticated,)
    http_method_names = ("put",)

    def get_object(self):
        return self.request.user

    def perform_update(self, serializer):
        user = self.get_object()

        if user.avatar:
            cloudinary.uploader.destroy(user.avatar.public_id)

        super().perform_update(serializer)

