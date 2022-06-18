from rest_framework import serializers
from django.contrib.auth.models import User
from .models import AppUser


class CreateAppUserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppUser

        fields = (
            "email",
            "password",
            "username",
            'name',
            'mobileNumber'
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
        user_profile = AppUser(
            user=user,
            username=validated_data["username"],
            name=validated_data['name'],
            mobileNumber=validated_data['mobileNumber'],
            email=validated_data["email"],
        )
        user_profile.save()
        return user
