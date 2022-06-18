from django.urls import path

from mobile.views import AppUserProfileAPI, AppUserRegistrationAPI

urlpatterns = [
    path("register", AppUserRegistrationAPI.as_view(), name="register"),
    path('profile',AppUserProfileAPI.as_view(),name='app_user_profile')
]
