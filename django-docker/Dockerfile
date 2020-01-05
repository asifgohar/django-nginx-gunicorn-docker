# Dockerfile
FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev

# install django
RUN apt-get install -y python-django-common
#RUN apt-get install -y python3-django

RUN mkdir /code
WORKDIR /code

COPY requirements.txt /code/

RUN pip3 install -r requirements.txt

# copy django project data from local machine to docker image
COPY . /code

#RUN /bin/bash -c "django-admin startproject myFirstProject"

RUN /bin/bash -c "python3 ./myFirstProject/manage.py migrate"

EXPOSE 8000

CMD ["python3", "./myFirstProject/manage.py", "runserver", "127.0.0.1:8000"]
