FROM python:3.6-alpine

RUN adduser -D microblog

WORKDIR /home/mayank/Documents/Mountblue/python-flask

COPY requirements.txt requirements.txt
RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev
RUN python3 -m venv venv
RUN pip install --upgrade pip
RUN pip3 install --upgrade setuptools
RUN venv/bin/pip3 install -r requirements.txt
RUN pip3 install --upgrade pip
RUN venv/bin/pip3 install gunicorn

#COPY app app
COPY app.py  boot.sh  flask.sql server.py ./
COPY flask_blog flask_blog
RUN chmod +x boot.sh

ENV FLASK_APP app.py

RUN chown -R microblog:microblog ./
USER microblog

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
