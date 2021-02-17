from rest_framework import serializers

from .models import Cbhs1_Menu
from .models import Cbhs2_Menu
from .models import Cbhs3_Menu


class Cbhs_Serializer(serializers.ModelSerializer):
    class Meta:
        model = Cbhs1_Menu # 모델 설정
        fields = ('Days','B','L','D')