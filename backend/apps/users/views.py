from django.contrib.auth import get_user_model
from django.utils.decorators import method_decorator

from rest_framework import generics, status, viewsets
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response

from drf_yasg.utils import swagger_auto_schema

from .serializers import UserSerializer

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
    (allow any users)
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
class GetMyInfoView(generics.GenericAPIView):
    """
    get own info
    (allow authenticated users)
    """

    queryset = UserModel.objects.all()
    serializer_class = UserSerializer
    permission_classes = (IsAuthenticated,)

    def get(self, *args, **kwargs):
        user = self.request.user
        serializer = UserSerializer(user)
        return Response(serializer.data, status.HTTP_200_OK)


@method_decorator(name="list",
                  decorator=swagger_auto_schema(operation_id="get_users_info", responses={200: UserSerializer()}
                                                ),
                  )
class ListAllUsersView(viewsets.ReadOnlyModelViewSet):
    """
        /api/users/list/ - list all users
        /api/users/list/<int:pk>/ - list user by id
        (only for superuser)
    """

    queryset = UserModel.objects.all()
    serializer_class = UserSerializer
