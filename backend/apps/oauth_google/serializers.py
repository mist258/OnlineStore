from rest_framework import serializers


class OauthGoogleSerializer(serializers.Serializer): # todo
    """
        serialize received data from Google
    """
    email = serializers.EmailField()
    token = serializers.CharField()
