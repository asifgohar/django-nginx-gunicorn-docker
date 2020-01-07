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

4. Copy docker-compose.yml
5. Copy nginx directory(conf.d, django-docker)
6. Create Dockerfile, gunicorn.py in projectApp dir where manage.py file resides
7. Modify Dockerfile in projectsApp dir, change ENV variable DJANGO_PROJECT_NAME. Actually it's path to wsgi.py file.
8. Change allowed hosts in settings.py

ALLOWED_HOSTS = ["*"]

9. Add mysql database details in settings.py
```
# HOST name is the service name defined in docker-compose.yml file. If you noticed services in the docker-compose.yml file, service name for mysql is "mysql". so HOST name should be "mysql".
DATABASES = {
   'default': {
       'ENGINE': 'django.db.backends.mysql',
       'NAME': 'db',
       'USER': 'webapp1',
       'PASSWORD': 'webapppass1',
       'HOST': 'mysql',
       'OPTIONS': {
           'init_command': "set sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'"
       },
   }
}
```

#### Step 3: build docker image for your django project

cd myFirstProject # go to your project directory

sudo docker build -t abhishek235/myfirstapp:base-image .

***result will be something like this:***
```
Successfully built b03b1e885432
Successfully tagged abhishek235/myfirstapp:base-image
```
#### Step 4: Add docker image name for django web app in docker-compose.yml

comment "build" section which is used to create an image while execute compose build command

Add image section and pass image name to be used(check docker-compose.yml for your reference)

```
mywebapp:
    # build:
    #   context: ./myFirstProject #django project dir
    #   dockerfile: Dockerfile
    image: abhishek235/myfirstapp:base-image
```

#### Step 5: build docker compose

sudo docker-compose build --no-cache

sudo docker-compose up

```
If you have an image for your webapp and uploaded it to docker hub, you need not to build docker image in step 3. "docker-compose up" will download the image from docker hub if it will not be on the local machine. To make it clear, you can understand it by scenario: 
at local machine: create an image by following step 3
push the image to docker hub
on server, you need not to generate the image by following step 3. Just pass the image name as described in step 4 and do not use docker-compose build. You just have to "docker-compose up" with sudo.
```

#### Push docker image to docker hub

To push your images to docker hub, you need to login to your docker account before pushing your images. You can login to docker hub account using following command.
```
cat ./docker-password.txt | sudo docker login --username=<Docker_Hub_User_Name> --password-stdin
```
> _store docker-hub account password in docker-password.txt file_
```
sudo docker push yourhubusername/imageName
for example: sudo docker push abhishek235/myfirstapp:base-image
```

