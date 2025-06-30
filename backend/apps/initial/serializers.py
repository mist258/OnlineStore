from rest_framework import serializers

from .models import InitialTest


class InitialTestSerializer(serializers.ModelSerializer):
    class Meta:
        model = InitialTest
        fields = (
            'id',
            'any_text',
        )
        read_only_fields = (
            'id',
        )