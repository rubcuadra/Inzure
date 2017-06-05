from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.response import Response
from .models import *

from rest_framework import serializers

class AndroidSerializer(serializers.ModelSerializer):
    class Meta:    
        model = Android
        fields = '__all__'

# Create your views here.
class AndroidViewSet(viewsets.ModelViewSet):
    """
    A simple ViewSet for viewing and editing Androids.
    """
    queryset = Android.objects.all()
    serializer_class = AndroidSerializer

class MacSerializer(serializers.ModelSerializer):
    class Meta:    
        model = Mac
        fields = '__all__'

# Create your views here.
class MacViewSet(viewsets.ModelViewSet):
    """
    A simple ViewSet for viewing and editing Macs.
    """
    queryset = Mac.objects.all()
    serializer_class = MacSerializer