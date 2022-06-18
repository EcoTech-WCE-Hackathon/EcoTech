from django.urls import path

from mobile.views import (
    AppUserProfileAPI,
    AppUserRegistrationAPI,
    GetStatsAPI,
    ReportEWasteAPI,
)

urlpatterns = [
    path("register", AppUserRegistrationAPI.as_view(), name="register"),
    path("profile", AppUserProfileAPI.as_view(), name="app_user_profile"),
    path("stats", GetStatsAPI.as_view(), name="user_stats"),
    path("upload", ReportEWasteAPI.as_view(), name="image_upload"),
]
