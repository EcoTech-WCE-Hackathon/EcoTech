from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Admin


class CreateAdminProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Admin

        fields = (
            "email",
            "password",
            "username",
        )
        extra_kwargs = {
            "password": {"write_only": True},
        }

    def create(self, validated_data):
        user = User.objects.create(
            username=validated_data["username"],
            email=validated_data["email"],
        )
        user.set_password(validated_data["password"])
        user.save()
        user_profile = Admin(
            user=user,
            username=validated_data["username"],
            email=validated_data["email"],
        )
        user_profile.save()
        return user


class DashBoardStatsSerializer(serializers.Serializer):
    def create(self, validated_data):
        pass
