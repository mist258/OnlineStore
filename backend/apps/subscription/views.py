from django.contrib.auth import get_user_model

from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

UserModel = get_user_model()


class SubscribeUserForUpdateView(APIView):

    permission_classes = (IsAuthenticated,)

    def patch(self,request):
        user = request.user

        if user.subscription_updates_news:
            return Response(
                {"Details":"You have already updated your subscription news!"}
            )

        user.subscription_updates_news = True
        user.save(update_fields=["subscription_updates_news"])
        return Response({"Details":"You have updated your subscription news!"},
                        status=status.HTTP_200_OK)


class UnsubscribeUserFromUpdateView(APIView):

    permission_classes = (IsAuthenticated,)

    def patch(self,request):
        user = request.user

        if user.subscription_updates_news:

            user.subscription_updates_news = False
            user.save(update_fields=["subscription_updates_news"])
            return Response({"Details":"Your subscription was unsubscribed!"},
                            status=status.HTTP_200_OK)

        return Response({"Details":"You have not updated your subscription news!"})
