#!/bin/bash

#install docker
sudo apt-get update
sudo apt-get -y install curl
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -f get-docker.sh

sudo docker run --rm -v $(pwd):/k8s-deploy ubuntu:bionic bash -c "cd /k8s-deploy; bash install-k8s.sh"
