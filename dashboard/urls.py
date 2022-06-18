from django.urls import path

from dashboard.views import AdminRegistrationAPI

urlpatterns = [
    path("register", AdminRegistrationAPI.as_view(), name="register"), 
]
