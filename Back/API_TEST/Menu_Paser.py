# Menu_Paser.py
# install module bs4, requests, lxml

import os
import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "API_TEST.settings")
django.setup()

from datetime import datetime
from django.utils.dateformat import DateFormat

from bs4 import BeautifulSoup
import requests

from menu_data.models import Cbhs1_Menu


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

            else :
                B = '공란'
                L = '공란'
                D = '공란'

        # 동서울관
        elif (cbhs == 2):
            date = text.split('\n')
            if (len(date) > 17):
                DATE = date[2].split('(')[0]  # date
                B = date[7].strip()  # B
                L = date[12].strip()  # L
                D = date[17].strip()  # D

                B = B.replace(', ', '\n')
                L = L.replace(",", "\n")
                D = D.replace(",", "\n")

            else:
                B = '공란'
                L = '공란'
                D = '공란'




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


if __name__ == '__main__':
    menu_list = cbhs_paser(1, 0)

    for dic_menu in menu_list:
        str_date = dic_menu.get('DATE')
        print(str_date)
        date = datetime.strptime(str_date, "%y.%m.%d")

        b = dic_menu.get('B')
        l = dic_menu.get('L')
        d = dic_menu.get('D')

        print(date)
        print(b + '\n')
        print(l + '\n')
        print(d + '\n')



        Cbhs1_Menu(Days=date, B=b, L=l, D=d, B_num=0, D_num=0, L_num=0).save()
