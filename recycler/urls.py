from django.urls import path

from recycler.views import RecyclerRegistrationAPI, WasteListAPI

urlpatterns = [
    path("register", RecyclerRegistrationAPI.as_view(), name="register"),
    path("pickup", WasteListAPI.as_view(), name="waste"),
]
