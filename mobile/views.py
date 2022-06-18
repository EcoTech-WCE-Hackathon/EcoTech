from mobile.models import AppUser
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
        user = request.user
        app_user = AppUser.objects.get(user=request.user)
        resp = {
            'username':app_user.username,
            'name':app_user.name,
            'email':app_user.email,
            'tokens':app_user.tokens
        }
        return Response({"data":{'profile':resp}})