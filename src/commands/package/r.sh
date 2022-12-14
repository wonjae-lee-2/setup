#!/bin/bash

# Load software versions. (CONFIG_FOLDER is exported from 'vm.sh'.)
source $CONFIG_FOLDER/env.sh

# Check if the same version of R exists.
if [ ! -d /opt/R/$R_VERSION ]
then
    echo
    echo "R $R_VERSION does not exist. Please install R first."
    exit 1
fi

# Set environment variables.
export PROJECT_FOLDER=~/venv/r/$R_VERSION
export LINUX_CODENAME=$(lsb_release -cs)

# Install package dependencies.
sudo apt update
sudo apt install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev
    # libcurl4-openssl-dev - curl
    # libssl-dev - curl, GGally
    # libxml2-dev - xml2

# Remove renv infrastructure files.
if [ -d $PROJECT_FOLDER ]
then
    rm -r $PROJECT_FOLDER
fi

# Install packages.
Rscript $RESOURCES_FOLDER/requirements.r
