from unicodedata import decimal
from dashboard.models import Report
from recycler.models import Recycler
from .serializers import CreateRecyclerProfileSerializer
from rest_framework.permissions import IsAuthenticated
from authentication.utils import get_tokens_for_user
from rest_framework import generics
from rest_framework.response import Response
import uuid


class RecyclerRegistrationAPI(generics.GenericAPIView):
    serializer_class = CreateRecyclerProfileSerializer
    throttle_scope = "user"

    def post(self, request, *args, **kwargs):

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        token = get_tokens_for_user(user)
        return Response({"data": {"token": token}})


class WasteListAPI(generics.GenericAPIView):
    permission_classes = (IsAuthenticated,)
    throttle_scope = "user"

    def get(self, request, *args, **kwargs):
        reports = Report.objects.filter(approved=True, pickedUp=False).values()
        return Response({"data": {"waste": list(reports)}})

    def patch(self, request, *args, **kwargs):
        report = Report.objects.get(image_id=uuid.UUID(request.data["id"]))
        if request.data["approved"]:
            report.recycler = Recycler.objects.get(user=request.user)
            report.weight = request.data["weight"]
            report.pickedUp = True
            report.appUser.tokens += report.weight * 10
            report.appUser.save()
            report.save()
            return Response({"message": "Picked Up Successfully"})
        else:
            report.approved = False
            report.save()
            return Response({"message": "Marked as False Positive"})
