#!/bin/bash

# Load software versions. (CONFIG_FOLDER is exported from 'vm.sh'.)
source $CONFIG_FOLDER/env.sh

# Check if the same version exists already.
if [ $(rstudio-server version | cut -d " " -f 1) = $RSTUDIO_VERSION ]
then
    echo
    echo "RStudio $RSTUDIO_VERSION already exists."
    exit 1
fi

# Set environment variables. RSTUDIO_VERSION is either exported from `install.sh` or read from user input.
RSTUDIO_VERSION_FILENAME=$(echo $RSTUDIO_VERSION | sed 's/+/-/')

# Install dependencies.
sudo apt update
sudo apt install -y --no-install-recommends \
    wget \
    gdebi-core

# Download RStudio. (DOWNLOAD_FOLDER is exported from 'vm.sh'.)
cd $DOWNLOAD_FOLDER
ARCHITECTURE=$(dpkg --print-architecture)
if [ $ARCHITECTURE = "arm64" ]
then
    wget https://s3.amazonaws.com/rstudio-ide-build/server/jammy/arm64/rstudio-server-$RSTUDIO_VERSION_FILENAME-arm64.deb
elif [ $ARCHITECTURE = "amd64" ]
then
    wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-$RSTUDIO_VERSION_FILENAME-amd64.deb
fi

# Install RStudio.
sudo gdebi rstudio-server-$RSTUDIO_VERSION_FILENAME-$ARCHITECTURE.deb

# Remove the downloaded file.
sudo rm $DOWNLOAD_FOLDER/rstudio-server-$RSTUDIO_VERSION_FILENAME-$ARCHITECTURE.deb

# Stop RStudio Server.
sudo systemctl stop rstudio-server

# Stop RStudio Server from starting automatically at startup.
sudo systemctl disable rstudio-server

# Change password for ubuntu.
echo ubuntu:wildgrape | sudo chpasswd