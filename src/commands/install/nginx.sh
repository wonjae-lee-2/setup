#!/bin/bash

# Check the latest version of nginx. https://nginx.org/

# Check if nginx exists already.
if command -v nginx &> /dev/null
then
    echo
    echo "nginx already exists."
    exit 1
fi

# Install dependencies.
sudo apt update
sudo apt -y install \
    curl \
    gnupg2 \
    ca-certificates \
    lsb-release \
    ubuntu-keyring

# Install nginx.
curl https://nginx.org/keys/nginx_signing.key \
    | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx
sudo apt update
sudo apt -y install nginx
