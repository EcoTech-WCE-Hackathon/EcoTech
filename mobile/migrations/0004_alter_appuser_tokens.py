# Generated by Django 4.0.5 on 2022-06-18 12:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mobile', '0003_alter_appuser_tokens'),
    ]

    operations = [
        migrations.AlterField(
            model_name='appuser',
            name='tokens',
            field=models.FloatField(default=0),
        ),
    ]
