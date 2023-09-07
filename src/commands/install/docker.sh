#!/bin/bash

# Check instructions to install Docker Engine on Ubuntu. https://docs.docker.com/engine/install/ubuntu/

# Check if Docker exists already.
if command -v docker &> /dev/null
then
    echo
    echo "Docker already exists."
    exit 1
fi

# Set environment variables.
# GPG_KEY_PATH=/usr/share/keyrings/docker.gpg

# Uninstall old versions.
# for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key.
sudo apt-get update
sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources.
echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install the latest Docker packages.
sudo apt-get -y install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# create the docker group and add the default user.
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Authenticate Docker to ECR.
# aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 284409997699.dkr.ecr.us-east-1.amazonaws.com
