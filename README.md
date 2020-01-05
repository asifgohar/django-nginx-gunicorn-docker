# django-nginx-gunicorn-docker
django+nginx+gunicorn+docker

#### Step 1: Install docker, docker-compose, python, pip, django

Download init-django-setup. This includes installation commands for docker, docker-compose, python, pip, django.

_run in terminal:_
```
cd init-django-setup
/bin/bash init-django-setup.sh
```
#### Step 2: Check sample project django-docker for the reference

1. sample project with name myFirstProject
2. Create requirements.txt in project directory where manage.py resides
3. Add django and gunicorn in requirements.txt

> You can skip step 1,2 and 3 if you have created django project using init-django-project/init-django-setup.sh

> Step 1,2 and 3 are done in init-django-project/init-django-setup.sh file. Kindly check to ensure whether requirements.txt file is in project's directory parallel to manage.py

4. Copy docker-compose.yaml
5. Copy nginx directory(conf.d, django-docker)
6. Create Dockerfile, gunicorn.py in projectApp dir where manage.py file resides
7. Modify Dockerfile in projectsApp dir, change ENV variable PROJECT_DIR
8. Change allowed hosts in settings.py
ALLOWED_HOSTS = ["*"]

#### Step 3: build docker image for your django project

cd myFirstProject # go to your project directory

sudo docker build -t abhishek235/myfirstapp .

***result will be something like this:***
```
Successfully built b03b1e885432
Successfully tagged abhishek235/myfirstapp:latest
```
#### Step 4: Add docker image name for django web app in docker-compose.yml

comment "build" section which is used to create an image while execute compose build command

Add image section and pass image name to be used(check docker-compose.yml for your reference)

```
mywebapp:
    # build:
    #   context: ./myFirstProject #django project dir
    #   dockerfile: Dockerfile
    image: abhishek235/myfirstapp:latest
```

#### Step 5: build docker compose

sudo docker-compose build --no-cache

sudo docker-compose up
