from django.urls import path

from dashboard.views import AdminRegistrationAPI, GetStatsAPI

urlpatterns = [
    path("register", AdminRegistrationAPI.as_view(), name="register"),
    path("stats", GetStatsAPI.as_view(), name="dashboard_stats"),
]
