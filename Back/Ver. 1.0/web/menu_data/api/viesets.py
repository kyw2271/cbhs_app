from rest_framework import (
    viewsets,
    status,
    mixins,
)
from rest_framework.decorators import action

from .serializer import *

from menu_data.models import *



class Cbhs1_Menu_ViewSet(viewsets.ModelViewSet):

    # 날짜 get
    queryset = Cbhs1_Menu.objects.all()
    serializer_class = Cbhs1_Serializer



    def get_queryset(self):
        now_date = datetime.now()
        end_date = now_date + timedelta(days=6)
        return Cbhs1_Menu.objects.filter(Days__range =(now_date, end_date))


    @action(detail=False, methods=('POST',), url_path='like', http_method_names=('post',), )
    def like(self, request, *args, **kwargs):
        day = request.data.get('day')
        bld = request.data.get('bld')






class Cbhs2_Menu_ViewSet(viewsets.ModelViewSet):

    # 날짜 get
    queryset = Cbhs2_Menu.objects.all()
    serializer_class = Cbhs2_Serializer



    def get_queryset(self):
        now_date = datetime.now()
        end_date = now_date + timedelta(days=6)
        return Cbhs2_Menu.objects.filter(Days__range =(now_date, end_date))




