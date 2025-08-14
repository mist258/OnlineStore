from rest_framework.serializers import ModelSerializer

from apps.users.serializers import UserSerializer

from .models import Review


class ReviewSerializer(ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = Review
        fields = ("id",
                  "is_approved",
                  "grade",
                  "date",
                  "comment",
                  "user",)

        read_only_fields = ("id",
                            "is_approved",
                            "date",
                            "user",)