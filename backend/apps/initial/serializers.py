from rest_framework import serializers

from .models import InitialTest


class InitialTestSerializer(serializers.ModelSerializer):
    class Meta:
        model = InitialTest
        fields = (
            'id',
            'any_text',
            'photo',
        )
        read_only_fields = (
            'id',
        )

class InitialPhotoSerializer(serializers.ModelSerializer):
    class Meta:
        model = InitialTest
        fields = (
            'photo',
        )
