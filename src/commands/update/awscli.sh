#!/bin/bash

# Check the latest version of AWS CLI. https://awscli.amazonaws.com/v2/documentation/api/latest/index.html

# Install dependencies.
sudo apt update
sudo apt install -y unzip

# Install the AWS CLI.
cd $DOWNLOAD_FOLDER
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --update

# Delete the downloaded file.
sudo rm awscliv2.zip

# Configure the AWS CLI based on user credentials.
aws configure
