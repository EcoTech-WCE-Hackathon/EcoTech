from django.contrib import admin

from .models import Admin, Report, Transaction

# Register your models here.
admin.site.register(Admin)
admin.site.register(Transaction)
admin.site.register(Report)