from rest_framework import serializers

from .models import Cbhs1_Menu
from .models import Cbhs2_Menu
from .models import Cbhs3_Menu

#######################

from rest_framework import viewsets


from datetime import datetime, timedelta


# serializer
class Cbhs1_Serializer(serializers.ModelSerializer):
    class Meta:
        model = Cbhs1_Menu # 모델 설정

        # Days -> YY년 mm월 dd일
        # 당일 포함 7개
        #  Days == NULL
        fields = ('Days','B','L','D',)

class Cbhs2_Serializer(serializers.ModelSerializer):
    class Meta:
        model = Cbhs2_Menu # 모델 설정

        # Days -> YY년 mm월 dd일
        # 당일 포함 7개
        #  Days == NULL
        fields = ('Days','B','L','D',)




# views

class Cbhs1_Menu_ViewSet(viewsets.ModelViewSet):

    # 날짜 get
    queryset = Cbhs1_Menu.objects.all()
    serializer_class = Cbhs1_Serializer



    def get_queryset(self):
        now_date = datetime.now()
        end_date = now_date + timedelta(days=6)
        return Cbhs1_Menu.objects.filter(Days__range =(now_date, end_date))





class Cbhs2_Menu_ViewSet(viewsets.ModelViewSet):

    # 날짜 get
    queryset = Cbhs2_Menu.objects.all()
    serializer_class = Cbhs2_Serializer



    def get_queryset(self):
        now_date = datetime.now()
        end_date = now_date + timedelta(days=6)
        return Cbhs2_Menu.objects.filter(Days__range =(now_date, end_date))
