FROM ubuntu
MAINTAINER kyw <kyw2271@naver.com>

RUN apt-get update
WORKDIR /usr/src/app
RUN apt install -y cron
COPY requirements.txt ./
RUN apt-get install -y python3-pip python3-dev
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

COPY . .

EXPOSE 8000
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]