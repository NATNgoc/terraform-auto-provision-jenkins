#!/bin/bash

# This script only for debian linux and it is using convinient script so to say it not good for prod
# Please keep it in mind before using

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh

docker pull jenkins/jenkins

docker run  -d --name jenkins -p 8080:8080 -p 50000:50000 --restart=on-failure -v jenkins_home:/var/jenkins_home jenkins/jenkins
