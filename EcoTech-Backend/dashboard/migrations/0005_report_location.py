# Generated by Django 4.0.5 on 2022-06-18 09:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0004_remove_report_id_report_image_id_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='report',
            name='location',
            field=models.TextField(default='hello'),
            preserve_default=False,
        ),
    ]
