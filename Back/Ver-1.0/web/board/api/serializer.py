from rest_framework import serializers
from django.contrib.auth.models import Group
from board.models import *



class Free_BoardSerializer(serializers.ModelSerializer):
    reply = serializers.SerializerMethodField()
    # reply = RecursiveSerializer(many=True, read_only=True)


    class Meta:
        model = Free_Board
        fields = ('id','parnet','created_at', 'content', 'reply')

    def get_reply(self, instance):
        # recursive
        serializer = self.__class__(instance.reply, many=True)
        serializer.bind('', self)
        return serializer.data


class NoticeSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Notice
        fields = ('id','created_at', 'content')
