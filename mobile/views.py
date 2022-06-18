from datetime import datetime,timedelta
from mobile.models import AppUser
from dashboard.models import Report
from .serializers import CreateAppUserProfileSerializer
from rest_framework.permissions import IsAuthenticated
from authentication.utils import get_tokens_for_user
from rest_framework import generics
from rest_framework.response import Response



class AppUserRegistrationAPI(generics.GenericAPIView):
    serializer_class = CreateAppUserProfileSerializer

    def post(self, request, *args, **kwargs):

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        token = get_tokens_for_user(user)
        return Response({"data": {"token": token}})

class AppUserProfileAPI(generics.GenericAPIView):
    permission_classes = (IsAuthenticated,)

    def get(self,request,*args,**kwargs):
        app_user = AppUser.objects.get(user=request.user)
        resp = {
            'username':app_user.username,
            'name':app_user.name,
            'email':app_user.email,
            'tokens':app_user.tokens
        }
        return Response({"data":{'profile':resp}})

class GetStatsAPI(generics.GenericAPIView):
    permission_classes = (IsAuthenticated,)

    def get(self,request,*args,**kwargs):
        app_user = AppUser.objects.get(user=request.user)
        reports = Report.objects.filter(appUser=app_user)
        total_reports = len(reports)
        total_picked_up = 0
        total_approved = 0
        weight = 0
        today = datetime.now()
        prev_week = today - timedelta(7)
        prev_week_reports = []
        for report in reports:
            if(report['approved']):
                total_approved+=1
                if(report['pickedUp']):
                    weight += report['weight']
                    total_picked_up+=1
            if(prev_week<=report['created_at']<=today):
                prev_week_reports.append(report)
        toxins = weight*0.1
        
        resp = {
            'toxins':toxins,
            'weight':weight,
            'prev_week_reports':prev_week_reports,
            'total_reports':total_reports,
            'total_approved':total_approved,
            'total_picked_up':total_picked_up,
        }
        return Response({"data": {"stats": resp}})

class ReportEWasteAPI(generics.GenericAPIView):
    permission_classes = (IsAuthenticated,)

    def post(self,request,*args,**kwargs):
        pass