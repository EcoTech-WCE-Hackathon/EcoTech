from dashboard.models import Report
from recycler.models import Recycler
from mobile.models import AppUser
from dashboard.utils import getTransactions
from .serializers import CreateAdminProfileSerializer, DashBoardStatsSerializer
from rest_framework.permissions import IsAuthenticated
from authentication.utils import get_tokens_for_user
from rest_framework import generics
from rest_framework.response import Response
from django.utils import timezone
from datetime import timedelta


class AdminRegistrationAPI(generics.GenericAPIView):
    serializer_class = CreateAdminProfileSerializer
    throttle_scope = "user"

    def post(self, request, *args, **kwargs):

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        token = get_tokens_for_user(user)
        return Response({"data": {"token": token}})


class GetStatsAPI(generics.GenericAPIView):
    permission_classes = (IsAuthenticated,)
    throttle_scope = "user"
    serializer_class = DashBoardStatsSerializer

    def get(self, request, *args, **kwargs):
        reports = Report.objects.all()
        recyclers = len(Recycler.objects.all())
        appusers = len(AppUser.objects.all())
        total_reports = len(reports)
        total_picked_up = 0
        total_approved = 0
        weight = 0
        today = timezone.now()
        prev_week = today - timedelta(7)
        prev_week_reports_approved = []
        prev_week_reports_picked = []
        waste_types = {}
        for report in reports:
            if report.wasteType in waste_types.keys():
                waste_types[report.wasteType] += 1
            else:
                waste_types[report.wasteType] = 1
            if report.approved:
                total_approved += 1
                if report.pickedUp:
                    weight += report.weight
                    total_picked_up += 1
                if prev_week <= report.created_at <= today:
                    recycler = None
                    if report.recycler:
                        recycler = report.recycler.username
                    else:
                        recycler = report.recycler
                    cur_report = {
                        "approved": True,
                        "weight": report.weight,
                        "wasteType": report.wasteType,
                        "recycler": recycler,
                        "location": report.location,
                        "picked_up": report.pickedUp,
                        "created_at": report.created_at,
                        "updated_at": report.updated_at,
                    }
                    if report.pickedUp:
                        prev_week_reports_picked.append(cur_report)
                    else:
                        prev_week_reports_approved.append(cur_report)
        toxins = weight * 0.1

        # only these 4 values are hardcoded for now others are dynamic
        top_5_states = {
            "MAH": 12,
            "UP": 19,
            "BH": 3,
            "KT": 5,
            "J&K": 2,
        }
        waste_in = [40, 90, 50, 100, 140, 20, 70]
        waste_out = [100, 120, 30, 40, 90, 110, 10]
        transactions = getTransactions()

        resp = {
            "waste_types": waste_types,
            "toxins": toxins,
            "weight": weight,
            "total_recyclers": recyclers,
            "total_reports": total_reports,
            "total_approved": total_approved,
            "total_picked_up": total_picked_up,
            "prev_week_reports_approved": prev_week_reports_approved,
            "prev_week_reports_picked": prev_week_reports_picked,
            "appusers": appusers,
            "top_5_states": top_5_states,
            "waste_out": waste_out,
            "waste_in": waste_in,
            "income": 18930,
            "transactions": transactions,
        }
        return Response({"data": {"stats": resp}})
