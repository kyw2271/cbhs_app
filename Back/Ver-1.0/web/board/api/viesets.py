from rest_framework import (
    viewsets,
    status,
    mixins,
)
from rest_framework.decorators import action

from .serializer import *

from board.models import *

from rest_framework.response import Response



from rest_framework.pagination import PageNumberPagination
class Free_BoardPagination(PageNumberPagination):
    page_size = 5



class Free_BoardViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset =Free_Board.objects.exclude(parnet__isnull=False)
    serializer_class = Free_BoardSerializer
    pagination_class = Free_BoardPagination
    #filterset_fields = ['id','partner','client','secret','content','answer']


    @action(detail=False, methods=('POST',), url_path='', http_method_names=('post',))
    def Free_Board_post(self, request, *args, **kwargs):
        
        contentTXT = request.data.get('content')


        Free_Board.objects.create(
            
            content = contentTXT,
            
            )
        
        return Response(
                    status=status.HTTP_201_CREATED,
                    data={'message': '등록 완료'},
                ) 

    @action(detail=False, methods=('POST',), url_path='delete', http_method_names=('post',))
    def Free_Board_delete(self, request, *args, **kwargs):
        Free_BoardID = request.data.get('Free_BoardID')


        if Free_Board.objects.filter(id = Free_BoardID).exists() :
            Free_Board.objects.filter(id = Free_BoardID).delete()
            return Response(
                status=status.HTTP_201_CREATED,
                data={'message': '삭제가 완료되었습니다.'},
            )

        else : 
            return Response(
                    status=status.HTTP_400_BAD_REQUEST,
                    data={'message': '이미 삭제된 글입니다.'},
                )





    @action(detail=False, methods=('POST',), url_path='answer', http_method_names=('post',))
    def answer_post(self, request, *args, **kwargs):
        
        
        contentTXT = request.data.get('content')
        Free_BoardID = request.data.get('Free_BoardID')
        stateNUM = request.data.get('state')
        
        
        
        if Free_Board.objects.filter(id = Free_BoardID).exists() :

            parent = Free_Board.objects.get(id = Free_BoardID)

            Free_Board.objects.create(
                parnet = parent,
                content = contentTXT,
            )

        


            return Response(
                        status=status.HTTP_201_CREATED,
                        data={'message': '답글이 등록되었습니다.'},
                    ) 

        else :
            return Response(
                    status=status.HTTP_400_BAD_REQUEST,
                    data={'message': '이미 삭제된 글입니다.'},
                )





class NoticeViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset =Notice.objects.all()
    serializer_class = NoticeSerializer