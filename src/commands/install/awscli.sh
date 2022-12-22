#!/bin/bash

# Check the latest version of AWS CLI. https://awscli.amazonaws.com/v2/documentation/api/latest/index.html

# Check if AWS CLI exists already.
if command -v aws &> /dev/null
then
    echo
    echo "AWS CLI already exists."
    exit 1
fi

# Install dependencies.
sudo apt update
sudo apt install -y --no-install-recommends \
    curl \
    ca-certificates \
    unzip

# Install the AWS CLI.
cd $DOWNLOAD_FOLDER
ARCHITECTURE=$(uname -m)
curl "https://awscli.amazonaws.com/awscli-exe-linux-$ARCHITECTURE.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Delete the downloaded file.
sudo rm awscliv2.zip

# Configure the AWS CLI based on user credentials.
aws configure

# Download and install the Session Manager plugin.
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_arm64/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb

# Delete the downloaded file.
rm session-manager-plugin.deb
