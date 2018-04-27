FROM python:3.6.5-stretch
RUN apt-get update -y
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