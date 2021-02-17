from django.shortcuts import render

from rest_framework import viewsets

from .serials import Cbhs_Serializer

from .models import Cbhs1_Menu
from .models import Cbhs2_Menu
from .models import Cbhs3_Menu

class Cbhs1_Menu_ViewSet(viewsets.ModelViewSet):

    queryset = Cbhs1_Menu.objects.all()
    serializer_class = Cbhs_Serializer



# Create your views here.
