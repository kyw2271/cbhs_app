from django.db import models

# Create your models here.

tm = ['월', '화', '수', '목', '금', '토', '일']


class Cbhs1_Menu (models.Model): # 서서울관 식단 모델
    # 식단 날짜
    Days = models.DateField()

    # 식단 아침(B), 점심(L) 저녁(D)
    B = models.CharField ('아침',max_length=255)
    L = models.CharField('점심',max_length=255)
    D = models.CharField('저녁',max_length=255)

    # 각 식단별 알람 울린 횟수 (먹은 횟수 나중에 필요)
    B_num = models.IntegerField('아침 좋아요',default=0)
    L_num = models.IntegerField('점심 좋아요',default=0)
    D_num = models.IntegerField('저녁 좋아요',default=0)

    class Meta:
        verbose_name = '서서울관 하루식단'
        verbose_name_plural = '서서울관 하루식단'
    
    def __str__(self):
        return str(self.Days) +' '+ tm[self.Days.weekday()]



class Cbhs2_Menu(models.Model):  # 동서울관 식단 모델
    # 식단 날짜
    Days = models.DateField()

        # 식단 아침(B), 점심(L) 저녁(D)
    B = models.CharField ('아침',max_length=255)
    L = models.CharField('점심',max_length=255)
    D = models.CharField('저녁',max_length=255)

    # 각 식단별 알람 울린 횟수 (먹은 횟수 나중에 필요)
    B_num = models.IntegerField('아침 좋아요',default=0)
    L_num = models.IntegerField('점심 좋아요',default=0)
    D_num = models.IntegerField('저녁 좋아요',default=0)

    class Meta:
        verbose_name = '동서울관 하루식단'
        verbose_name_plural = '동서울관 하루식단'

    def __str__(self):
        return str(self.Days) +' '+ tm[self.Days.weekday()]



class Cbhs3_Menu(models.Model):  # 청주관 식단 모델

    # 식단 날짜
    Days = models.DateField()

        # 식단 아침(B), 점심(L) 저녁(D)
    B = models.CharField ('아침',max_length=255)
    L = models.CharField('점심',max_length=255)
    D = models.CharField('저녁',max_length=255)

    # 각 식단별 알람 울린 횟수 (먹은 횟수 나중에 필요)
    B_num = models.IntegerField('아침 좋아요',default=0)
    L_num = models.IntegerField('점심 좋아요',default=0)
    D_num = models.IntegerField('저녁 좋아요',default=0)

    class Meta:
        verbose_name = '청주관 하루식단'
        verbose_name_plural = '청주관 하루식단' 

    def __str__(self):
        return str(self.Days) +' '+ tm[self.Days.weekday()]