#!/bin/bash

initDir=$PWD # used to copy requirements.txt

####### Install docker #######
while true; do
    echo "" #insert new line
    programName=Docker
    read -p "Do you wish to install $programName? (Y/N/Q-quit) " userAns
    case $userAns in
        [Yy]* )
            echo "Installing the program...";
            # start Installation commands
            sudo apt-get update;
            sudo apt-get install \
                apt-transport-https \
                ca-certificates \
                curl \
                gnupg-agent \
                software-properties-common;

            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
            sudo apt-key fingerprint 0EBFCD88;

            sudo add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable";

            sudo apt-get install docker-ce docker-ce-cli containerd.io;
            #sudo docker run hello-world;
            # end Installation commands

            break;;
        [Nn]* )
            echo "skip $programName installation";
            break;;
        [Qq]* ) 
            exit 1;;
        * ) echo "Please answer yes or no.";;
    esac
done

####### Install docker compose #######
while true; do
    echo "" #insert new line
    programName=Docker-compose
    read -p "Do you wish to install $programName? (Y/N/Q-quit) " userAns
    case $userAns in
        [Yy]* )
            echo "Installing the program...";

            # start Installation commands
            sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;
            sudo chmod +x /usr/local/bin/docker-compose;
            docker-compose --version;
            # end Installation commands

            break;;
        [Nn]* )
            echo "skip $programName installation";
            break;;
        [Qq]* ) 
            exit 1;;
        * ) echo "Please answer yes or no.";;
    esac
done

####### Install python3 & pip3 #######
while true; do
    echo "" #insert new line
    programName="python, pip3 and django"
    read -p "Do you wish to install $programName? (Y/N/Q-quit) " userAns
    case $userAns in
        [Yy]* )
            echo "Installing the program...";

            # start Installation commands
            sudo apt install python-dev python3.7 python3-pip
            pip3 install django
            # end Installation commands

            break;;
        [Nn]* )
            echo "skip $programName installation";
            break;;
        [Qq]* ) 
            exit 1;;
        * ) echo "Please answer yes or no.";;
    esac
done


####### create django project directory #######
read -p "Create Django project directory with name: " djangoProjectDir

#Check if a directory does not exist
if [[ (! -z $djangoProjectDir) && (! -d ~/${djangoProjectDir}) ]]; then
    mkdir ~/${djangoProjectDir};
    cd ~/${djangoProjectDir};
    #pwd
    #echo $initDir

    ####### create django project #######
    read -p "Django project name: " djangoProjectName

    #Check if a project name is not empty
    if [[ (-z $djangoProjectName) || ("$djangoProjectName" == "test") ]]; then
        printf "Invalid django project name"
        exit;
    else
        echo " non empty project name: $djangoProjectName"
        pwd
        echo ""
        sudo apt install python-django-common
        sudo apt install python3-django
        django-admin startproject $djangoProjectName

        # copy requirements.txt
        cp $initDir/requirements.txt ~/${djangoProjectDir}/${djangoProjectName}
    fi
else
    printf "Error: directory ~/${djangoProjectDir} already exist"
    exit;
fi


