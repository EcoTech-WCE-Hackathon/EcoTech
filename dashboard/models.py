from django.db import models
from django.db.models.deletion import CASCADE
from django.contrib.auth.models import User
import uuid

from mobile.models import AppUser
from recycler.models import Recycler

# Create your models here.
class Admin(models.Model):
    user = models.OneToOneField(User, on_delete=CASCADE, null=True, blank=True)
    username = models.CharField(max_length=256)
    password = models.CharField(max_length=256, blank=True, null=True)
    email = models.EmailField()

    def __str__(self) -> str:
        return self.username


class Transaction(models.Model):
    transactionType = models.BooleanField()
    appuser = models.ForeignKey(AppUser, on_delete=CASCADE, null=True, blank=True)
    recycler = models.ForeignKey(Recycler, on_delete=CASCADE, null=True, blank=True)
    amount = models.DecimalField(decimal_places=2, max_digits=10)


class Report(models.Model):
    WASTE_TYPE_CHOICES = (
        ("computer", "computer"),
        ("cables", "cables"),
        ("display", "display"),
        ("mobile", "mobile"),
        ("others", "others"),
    )

    approved = models.BooleanField(default=False)

    image = models.ImageField(upload_to="images/", default="/images/default.jpg")

    image_id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)

    image_name_s3 = models.CharField(max_length=256, null=True, blank=True)

    appUser = models.ForeignKey(AppUser, on_delete=CASCADE, null=True, blank=True)

    recycler = models.ForeignKey(Recycler, on_delete=CASCADE, null=True, blank=True)

    weight = models.DecimalField(
        decimal_places=2, max_digits=10, default=0, null=True, blank=True
    )

    wasteType = models.CharField(
        choices=WASTE_TYPE_CHOICES,
        default="others",
        blank=True,
        null=True,
        max_length=10,
    )

    location = models.TextField()

    pickedUp = models.BooleanField(default=False)

    created_at = models.DateTimeField(auto_now_add=True)

    updated_at = models.DateTimeField(auto_now=True)
