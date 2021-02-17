from rest_framework import serializers

from .models import Cbhs1_Menu
from .models import Cbhs2_Menu
from .models import Cbhs3_Menu

#######################

from rest_framework import viewsets



# serializer
class Cbhs_Serializer(serializers.ModelSerializer):
    class Meta:
        model = Cbhs1_Menu # 모델 설정
        fields = ('Days','B','L','D',)


# views

class Cbhs1_Menu_ViewSet(viewsets.ModelViewSet):

    queryset = Cbhs1_Menu.objects.all()
    serializer_class = Cbhs_Serializer
