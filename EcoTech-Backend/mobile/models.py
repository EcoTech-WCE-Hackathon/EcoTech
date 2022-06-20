from django.db import models
from django.db.models.deletion import CASCADE
from django.contrib.auth.models import User

# Create your models here.
class AppUser(models.Model):
    user = models.OneToOneField(User, on_delete=CASCADE, null=True, blank=True)
    name = models.CharField(max_length=256)
    username = models.CharField(max_length=256)
    password = models.CharField(max_length=256, blank=True, null=True)
    email = models.EmailField()
    mobileNumber = models.CharField(max_length=10)
    tokens = models.FloatField(default=0)

    def __str__(self) -> str:
        return self.username
