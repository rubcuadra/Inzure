# -*- coding: utf-8 -*-
# Generated by Django 1.10.4 on 2017-06-04 19:14
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('application', '0003_auto_20170604_1824'),
    ]

    operations = [
        migrations.RenameField(
            model_name='mac',
            old_name='identifier',
            new_name='memory',
        ),
        migrations.AddField(
            model_name='mac',
            name='serial',
            field=models.CharField(default=' ', max_length=80),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='mac',
            name='uuid',
            field=models.CharField(default=' ', max_length=80),
            preserve_default=False,
        ),
    ]
