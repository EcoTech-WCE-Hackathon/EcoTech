from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Recycler


class CreateRecyclerProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recycler

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
        user_profile = Recycler(
            user=user,
            username=validated_data["username"],
            email=validated_data["email"],
        )
        user_profile.save()
        return user


class WasteListSerializer(serializers.Serializer):
    approved = serializers.BooleanField()
    image_id = serializers.CharField(max_length=256)
    weight = serializers.FloatField()
