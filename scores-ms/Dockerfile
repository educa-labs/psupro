FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential
RUN mkdir /app
WORKDIR /app
# TODO: copy all neded files and serialized models 
COPY ./newton ./newton
COPY ./score_regressor ./score_regressor
COPY ./db.py ./db.py
COPY ./main.py ./main.py
COPY ./requirements.txt ./requirements.txt
COPY ./wsgi.py ./wsgi.py

RUN pip install -r requirements.txt