# -*- coding: utf-8 -*-
# Generated by Django 1.10.4 on 2017-06-04 18:04
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('application', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Mac',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('identifier', models.CharField(max_length=80)),
                ('model', models.CharField(max_length=80)),
                ('proc', models.CharField(max_length=80)),
            ],
        ),
    ]