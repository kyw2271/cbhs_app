from rest_framework import serializers

from menu_data.models import *


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