from datetime import timedelta
from mobile.models import AppUser
from dashboard.models import Report
from mobile.utils import upload_image_to_s3
from mobile.predictor import Predictor
from .serializers import (
    CreateAppUserProfileSerializer,
    UserProfileSerializer,
    UserStatsSerializer,
)
from rest_framework.permissions import IsAuthenticated
from authentication.utils import get_tokens_for_user
from rest_framework import generics
from rest_framework.response import Response
from django.utils import timezone
from .serializers import ReportEWasteSerializer


class AppUserRegistrationAPI(generics.GenericAPIView):
    throttle_scope = "user"
    serializer_class = CreateAppUserProfileSerializer

    def post(self, request, *args, **kwargs):

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        token = get_tokens_for_user(user)
        return Response({"data": {"token": token}})


class AppUserProfileAPI(generics.GenericAPIView):
    serializer_class = UserProfileSerializer
    permission_classes = (IsAuthenticated,)
    throttle_scope = "user"

    def get(self, request, *args, **kwargs):
        app_user = AppUser.objects.get(user=request.user)
        resp = {
            "username": app_user.username,
            "name": app_user.name,
            "email": app_user.email,
            "tokens": app_user.tokens,
        }
        return Response({"data": {"profile": resp}})


class GetStatsAPI(generics.GenericAPIView):
    serializer_class = UserStatsSerializer
    permission_classes = (IsAuthenticated,)
    throttle_scope = "user"

    def get(self, request, *args, **kwargs):
        app_user = AppUser.objects.get(user=request.user)
        reports = Report.objects.filter(appUser=app_user)
        total_reports = len(reports)
        total_picked_up = 0
        total_approved = 0
        weight = 0
        today = timezone.now()
        prev_week = today - timedelta(7)
        prev_week_reports = []
        for report in reports:
            if report.approved:
                total_approved += 1
                if report.pickedUp:
                    weight += report.weight
                    total_picked_up += 1
            if prev_week <= report.created_at <= today:
                cur_report = {
                    "approved": True,
                    "weight": report.weight,
                    "wasteType": report.wasteType,
                    "recycler": report.recycler,
                    "location": report.location,
                    "picked_up": report.pickedUp,
                    "created_at": report.created_at,
                    "updated_at": report.updated_at,
                }
                prev_week_reports.append(cur_report)
        toxins = weight * 0.1
        resp = {
            "toxins": toxins,
            "weight": weight,
            "total_reports": total_reports,
            "total_approved": total_approved,
            "total_picked_up": total_picked_up,
            "prev_week_reports": prev_week_reports,
        }
        return Response({"data": {"stats": resp}})


class ReportEWasteAPI(generics.GenericAPIView):
    serializer_class = ReportEWasteSerializer
    permission_classes = (IsAuthenticated,)
    throttle_scope = "user"

    def post(self, request, *args, **kwargs):
        image = request.data["image"]
        location = request.data["location"]
        wasteType = request.data["wasteType"]
        appUser = AppUser.objects.get(user=request.user)
        approved = Predictor.predict(image)
        report = Report(
            approved=approved,
            image=image,
            appUser=appUser,
            wasteType=wasteType,
            location=location,
        )
        name = str(report.image_id)
        extension = image.name.split(".")[-1]
        report.image_name_s3 = name + "." + extension
        upload_image_to_s3(image, name, extension)
        report.image.name = name + "." + extension
        report.save()
        return Response(
            {"message": "successfully submitted", "data": {"approval_status": approved}}
        )
