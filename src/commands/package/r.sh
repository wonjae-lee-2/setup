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

# Install package dependencies.
sudo apt-get update
sudo apt-get install -y libgit2-dev
    #libgit2-dev - gert

# Install packages.
Rscript $RESOURCES_FOLDER/install.r