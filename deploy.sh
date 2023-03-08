#!/bin/bash
#08/03/2023

#for updating the linux os
sudo yum update -y

#For installing Docker
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl status docker

#For installing Docker compose
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

#install git
sudo yum install git -y

#cloning repository
git clone https://github.com/rvsp/reactjs-demo.git
cd reactjs-demo


#Creating Docker file
touch Dockerfile

echo "FROM node:16-alpine" > Dockerfile
echo "WORKDIR /opt/" >> Dockerfile
echo "COPY package.json /opt/" >> Dockerfile
echo "RUN npm install" >> Dockerfile
echo "COPY ./ /opt/" >> Dockerfile
echo "RUN npm run build" >> Dockerfile
echo "EXPOSE 80" >> Dockerfile
echo "CMD [\"npm\" ,\"run\", \"start\" ]" >> Dockerfile

#build image
sudo docker build . -t reactjs:v1

#Running a Docker container
sudo docker run -it -d -p 80:3000 reactjs:v1

#showing the running container
sudo docker ps
