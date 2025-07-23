from rest_framework import serializers


class GoogleOAuthSerializer(serializers.Serializer):
    """
        serialize received data from Google
    """
    email = serializers.EmailField()
    token = serializers.CharField()
