from django.db import models




# Create your models here.


class Cbhs1_Menu (models.Model): # 서서울관 식단 모델

    # 식단 날짜
    Days = models.DateField()


    # 식단 아침(B), 점심(L) 저녁(D)
    B = models.CharField (max_length=255)
    L = models.CharField(max_length=255)
    D = models.CharField(max_length=255)

    # 각 식단별 알람 울린 횟수 (먹은 횟수 나중에 필요)
    B_num = models.IntegerField()
    L_num = models.IntegerField()
    D_num = models.IntegerField()


class Cbhs2_Menu(models.Model):  # 동서울관 식단 모델

    # 식단 날짜
    Days = models.DateField()

    # 식단 아침(B), 점심(L) 저녁(D)
    B = models.CharField(max_length=255)
    L = models.CharField(max_length=255)
    D = models.CharField(max_length=255)

    # 각 식단별 알람 울린 횟수 (먹은 횟수 나중에 필요)
    B_num = models.IntegerField()
    L_num = models.IntegerField()
    D_num = models.IntegerField()

class Cbhs3_Menu(models.Model):  # 청주관 식단 모델

    # 식단 날짜
    Days = models.DateField()

    # 식단 아침(B), 점심(L) 저녁(D)
    B = models.CharField(max_length=255)
    L = models.CharField(max_length=255)
    D = models.CharField(max_length=255)

    # 각 식단별 알람 울린 횟수 (먹은 횟수 나중에 필요)
    B_num = models.IntegerField()
    L_num = models.IntegerField()
    D_num = models.IntegerField()

