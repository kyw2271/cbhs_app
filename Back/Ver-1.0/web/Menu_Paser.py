# Menu_Paser.py
# install module bs4, requests, lxml

import os
import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "server.settings")
django.setup()

from datetime import datetime
from django.utils.dateformat import DateFormat

from bs4 import BeautifulSoup
import requests


# models 메뉴
from menu_data.models import *



def cbhs_paser(cbhs=0, weeks=0):
    # cbhs - 1==서서울관, 2==동서울관 3== 청주관
    #  weeks - 0= 현재 주, - 과거, + 미래

    # url 학사별 분리
    if (cbhs <= 0 & cbhs > 3):
        return False

    if (cbhs == 1):
        cbh = ''
    elif (cbhs == 2):
        cbh = '2'
    elif (cbhs == 3):
        cbh = 'cj'

    week_menu = [{}, {}, {}, {}, {}, {}, {}]

    # requests
    menu_url = requests.get('http://www.cbhs' + cbh + '.kr/meal?searchWeek=' + str(weeks))
    html = menu_url.text
    soup = BeautifulSoup(html, 'lxml')

    # bs4 학사별 추출
    i = 0
    for ele in soup.find_all(attrs={'class': 'fplan_plan'}):
        text = ele.text

        # 서서울관
        if (cbhs == 1):
            date = text.split('"')

            DATE = date[0].split(' ')[0]  # date
            DATE = DATE.strip()

            # 예외처리
            if (len(date) > 5):

                B = date[1].strip()  # B
                L = date[3].strip()  # L
                D = date[5].strip()  # D

                B = B.replace('\t', '')
                L = L.replace('\t', '')
                D = D.replace('\t', '')

                B = B.replace('\n', ' ')
                L = L.replace('\n', ' ')
                D = D.replace('\n', ' ')

                B = B.replace('\r', '')
                L = L.replace('\r', '')
                D = D.replace('\r', '')

            else :
                B = "메뉴가 없어요."
                L = "메뉴가 없어요."
                D = "메뉴가 없어요."

        # 동서울관
        elif (cbhs == 2):
            date = text.split('\n')
            DATE = date[2].split('(')[0]  # date
            DATE = DATE.strip()

            if (  not(date[7] == '\t\t\t\t\t\xa0') ):


                B = date[7].strip()  # B
                L = date[12].strip()  # L
                D = date[17].strip()  # D

                B = B.replace(', ', ' ')
                L = L.replace(",", " ")
                D = D.replace(",", " ")

                B = B.replace('\t', '')
                L = L.replace('\t', '')
                D = D.replace('\t', '')


            else:
                B = "메뉴가 없어요."
                L = "메뉴가 없어요."
                D = "메뉴가 없어요."




        # 청주관 (미완)
        elif (cbhs == 3):
            print(text)
            date = text.split(' ')

            DATE = date[0].split('(')[0]  # date
            B = date[1].lstrip()  # B
            L = date[2].lstrip()  # L
            D = date[3].lstrip()  # D

        # 일별 메뉴 (총7개 일월화수목금) 모든자료형 str
        # DATE - 날짜
        # B - 아침
        # L - 점심
        # D - 저녁

        #return dic
        week_menu[i]['DATE'] = DATE
        week_menu[i]['B'] = B
        week_menu[i]['L'] = L
        week_menu[i]['D'] = D
        i += 1

        #test code - 식단 데이터가 return용 dic에 제대로 저장되었는지
        #print(DATE + ':::\n')
        #print(B + '\n')
        #print(L + '\n')
        #print(D + '\n')
        #print('------------------------------- '+ '\n')

    return week_menu



def cron_menu_cbhs():

    # 서서울관
    for i in range(0,2) :
        menu_list = cbhs_paser(1, i)

        for dic_menu in menu_list:
            str_date = dic_menu.get('DATE')
            date = datetime.strptime(str_date, "%y.%m.%d")

            b = dic_menu.get('B')
            l = dic_menu.get('L')
            d = dic_menu.get('D')

            print(date)
            print(b + '\n')
            print(l + '\n')
            print(d + '\n')

            # 해당 메뉴가 존재하면, BLD 바꿔주기
            if Cbhs1_Menu.objects.filter(Days = date).exists():

                Cbhs1_Menu.objects.get(Days=date).B = b
                Cbhs1_Menu.objects.get(Days=date).L = l
                Cbhs1_Menu.objects.get(Days=date).D = d
                Cbhs1_Menu.save()
            else:
                print("추가")
                Cbhs1_Menu(Days=date, B=b, L=l, D=d, B_num=0, D_num=0, L_num=0).save()

    # 동서울관
    for i in range(0,2) :
            menu_list = cbhs_paser(2, i)

            for dic_menu in menu_list:
                str_date = dic_menu.get('DATE')

                date = datetime.strptime(str_date, "%y.%m.%d")

                b = dic_menu.get('B')
                l = dic_menu.get('L')
                d = dic_menu.get('D')

                print(date)
                print(b + '\n')
                print(l + '\n')
                print(d + '\n')

                # 해당 메뉴가 존재하면, BLD 바꿔주기
                if Cbhs2_Menu.objects.filter(Days = date).exists():

                    Cbhs2_Menu.objects.get(Days=date).B = b
                    Cbhs2_Menu.objects.get(Days=date).L = l
                    Cbhs2_Menu.objects.get(Days=date).D = d
                    Cbhs1_Menu.save()
                else:
                    print("추가")
                    Cbhs2_Menu(Days=date, B=b, L=l, D=d, B_num=0, D_num=0, L_num=0).save()











if __name__ == '__main__':
    cron_menu_cbhs()
