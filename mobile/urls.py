from django.urls import path

from mobile.views import AppUserProfileAPI, AppUserRegistrationAPI, ReportEWasteAPI

urlpatterns = [
    path("register", AppUserRegistrationAPI.as_view(), name="register"),
    path("profile", AppUserProfileAPI.as_view(), name="app_user_profile"),
    path("upload", ReportEWasteAPI.as_view(), name="image_upload"),
]
