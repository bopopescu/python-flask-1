FROM python:3.6-alpine

RUN adduser -D microblog

WORKDIR /Music/flask-blog

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN pip3 install --upgrade setuptools
RUN venv/bin/pip3 install -r requirements.txt
RUN venv/bin/pip3 install gunicorn

COPY app app
COPY app.py  boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP app.py

RUN chown -R app:app ./
USER microblog

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]