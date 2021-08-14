FROM python:3.8.2
MAINTAINER kyw <kyw2271@naver.com>


ENV PYTHONUNBUFFERED=1


# 리눅스 설정
RUN apt-get update
RUN apt install -y cron
RUN apt-get install -y tzdata
RUN apt install -y nano



# 장고 및 파이썬 모듈- 기본 설치

COPY requirements.txt ./
RUN pip install --upgrade pip
RUN pip install -r requirements.txt


#파이썬 모듈 종속성 - DB연결 추가파일
RUN pip install psycopg2


#시간 관련
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

WORKDIR /web


#cron
CMD python manage.py crontab add