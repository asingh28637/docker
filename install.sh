#!/bin/bash

echo "Start install docker-ce"
curl -fsSL https://get.docker.com | bash
echo "Docker-ce install done"

echo "Start install docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
sudo chmod +x /usr/local/bin/docker-compose
echo "Docker-machine install done"

echo "Docker and docker-compose install is Done"
