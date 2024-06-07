#!/bin/bash 

# remove running conatianers
sudo docker rm -f $(docker ps -qa)

# create a network 
sudo docker network create lab-6-network 

# create a volume 
sudo docker volume create new-volume 

#build flask and mysql 
sudo docker build -t lab-6-mysql:5.7 db
sudo docker build -t lab-6-flask-app:latest flask-app

# run mysql container 
sudo docker run -d \
    --name mysql \
    --network lab-6network \
    lab-6-mysql:5.7

# run flask container 
sudo docker run -d \
    -e MYSQL_ROOT_PASSWORD=password \
    --name flask-app \
    --network lab-6-network \
    lab-6-flask-app:latest 

#run the nginx container 
sudo docker run -d \
    --name nginx \
    -p 80:80 \
    --network lab-6-network \
    --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf \
    nginx:latest 

sudo docker ps -a