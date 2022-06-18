from django.urls import path

from recycler.views import RecyclerRegistrationAPI
urlpatterns = [
    path("register", RecyclerRegistrationAPI.as_view(), name="register"),
]
