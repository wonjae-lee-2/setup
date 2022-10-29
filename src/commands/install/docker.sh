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
GPG_KEY_PATH=/usr/share/keyrings/docker.gpg

# Uninstall old versions.
#sudo apt remove \
#    docker \
#    docker-engine \
#    docker.io \
#    containerd runc

# Install dependencies.
sudo apt update
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Download the repository key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o $GPG_KEY_PATH

# Create the repository configuration.
echo "deb [arch=$(dpkg --print-architecture) signed-by=$GPG_KEY_PATH] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker from the repository.
sudo apt-get update
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

# create the docker group and add the default user.
sudo groupadd docker
sudo usermod -aG docker $USER

# Set up authentication to Google Cloud Artifact Registry. (The gcloud command cannot be executed within the folder synced by rclone.)
cd ~
gcloud auth configure-docker us-central1-docker.pkg.dev --quiet
