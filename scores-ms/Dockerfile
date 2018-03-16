FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential
RUN mkdir /app
WORKDIR /app
COPY ./score_predict ./score_predict
COPY ./db.py ./db.py
# TODO: copy all neded files and serialized models 
RUN pip install -r requirements.txt
ENTRYPOINT ["python3"]
CMD ["app.py"]