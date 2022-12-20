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
    unzip

# Install the AWS CLI.
cd $DOWNLOAD_FOLDER
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Delete the downloaded file.
sudo rm awscliv2.zip

# Configure the AWS CLI based on user credentials.
aws configure
