from django.utils.decorators import method_decorator

from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from drf_yasg.utils import swagger_auto_schema
from rest_framework_simplejwt.tokens import RefreshToken


@method_decorator(
    name="post", decorator=swagger_auto_schema(operation_id="log_out_user")
)
class LogOutUserView(APIView):
    """
    Log out user
    """

    permission_classes = (IsAuthenticated,)

    def post(self, request):
        try:
            refresh = request.data["refresh"]
            token = RefreshToken(refresh)
            token.blacklist()
            return Response(
                {"Details": "User is logged out successfully"},
                status.HTTP_205_RESET_CONTENT,
            )
        except Exception as e:
            return Response({"Details": str(e)}, status.HTTP_400_BAD_REQUEST)
