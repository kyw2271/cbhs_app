FROM ubuntu
MAINTAINER kyw <kyw2271@naver.com>

# 리눅스 설정
RUN apt-get update
WORKDIR /usr/src/app
RUN apt install -y cron



# 장고 및 파이썬 모듈
COPY requirements.txt ./
RUN apt-get install -y python3-pip python3-dev
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt





#시간 관련
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
RUN apt-get install -y tzdata
RUN apt install -y nano

COPY . .

#cron
RUN python3 manage.py crontab add


EXPOSE 8000
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]