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

# Install lsb-core
sudo apt update
sudo apt install -y --no-install-recommends lsb-core

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
    sudo rm -r $PROJECT_FOLDER
fi

# Initialize a project.
Rscript $RESOURCES_FOLDER/init.r

# Configure HTTP user agent and the repository URL in the user startup file.
echo 'options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])))' > $PROJECT_FOLDER/.Rprofile
echo 'options(repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/'$LINUX_CODENAME'/latest"))' >> $PROJECT_FOLDER/.Rprofile

# Install packages.
cd $PROJECT_FOLDER
Rscript $RESOURCES_FOLDER/install.r