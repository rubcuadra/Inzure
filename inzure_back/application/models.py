from __future__ import unicode_literals

from django.db import models

# Create your models here.
class Android(models.Model):
    modelid = models.CharField(max_length=80)
    operator = models.CharField(max_length=80)
    marca = models.CharField(max_length=80)
    model = models.CharField(max_length=80)
    imei = models.CharField(max_length=80)

class Mac(models.Model):
    model = models.CharField(max_length=80)
    proc = models.CharField(max_length=80)
    memory = models.CharField(max_length=80)
    serial = models.CharField(max_length=80)
    uuid = models.CharField(max_length=80)
    