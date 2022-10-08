#!/bin/bash

# Load software versions. (CONFIG_FOLDER is exported from 'vm.sh'.)
source $CONFIG_FOLDER/env.sh

# Check if the same version exists already.
if [ -d /opt/R/$R_VERSION ]
then
    echo
    echo "R $R_VERSION already exists."
    exit 1
fi

# Set folder paths.
UBUNTU_RELEASE_NUMBER=$(lsb_release -rs | sed 's/\.//')

# Install dependencies.
sudo apt update
sudo apt install -y gdebi-core

# Download R from RStudio. (DOWNLOAD_FOLDER is exported from 'vm.sh'.)
cd $DOWNLOAD_FOLDER
curl -O https://cdn.rstudio.com/r/ubuntu-$UBUNTU_RELEASE_NUMBER/pkgs/r-${R_VERSION}_1_amd64.deb

# Install R.
sudo gdebi -n r-${R_VERSION}_1_amd64.deb

# Create a symlink to R.
sudo ln -fs /opt/R/$R_VERSION/bin/R /usr/local/bin/R
sudo ln -fs /opt/R/$R_VERSION/bin/Rscript /usr/local/bin/Rscript

# Remove the downloaded file.
sudo rm $DOWNLOAD_FOLDER/r-${R_VERSION}_1_amd64.deb
