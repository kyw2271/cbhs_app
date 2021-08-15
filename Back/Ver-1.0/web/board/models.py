from django.db import models

# Create your models here.

# ------------------------------------------------------------------
# Model   : Free_Board
# Description : 자유게시판
# ------------------------------------------------------------------
class Free_Board(models.Model):

    
    parnet = models.ForeignKey('self', related_name='reply', on_delete=models.CASCADE, null=True, blank=True)

    
    created_at = models.DateTimeField('등록일자', auto_now_add=True)

    content = models.TextField('내용', null=True)

    class Meta:
        verbose_name = '자유 게시판'
        verbose_name_plural = '자유 게시판'
        ordering = ('-created_at',)

    def str(self):
        return str(self.content) 




# ------------------------------------------------------------------
# Model   : Notice
# Description : 공지사항
# ------------------------------------------------------------------
class Notice(models.Model):


    created_at = models.DateTimeField('등록일자', auto_now_add=True)
    content = models.TextField('내용', null=True)

    class Meta:
        verbose_name = '공지사항'
        verbose_name_plural = '공지사항'
        ordering = ('-created_at',)

    def str(self):
        return str(self.content) 