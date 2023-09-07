#!/bin/bash

# Get user input for software versions.
echo
echo "Check the latest version of Python. https://www.python.org/"
read -p "Which version of Python would you like to install? " PYTHON_VERSION
echo
echo "Check the latest version of R. https://www.r-project.org/ or https://cloud.r-project.org/"
read -p "Which version of R would you like to install? " R_VERSION
echo
echo "Check the latest version of RStudio. https://posit.co/ or https://dailies.rstudio.com/rstudio/elsbeth-geranium/server/jammy-arm64/"
read -p "Which version of RStudio would you like to install? " RSTUDIO_VERSION
echo
echo "Check the latest version of Spark. https://spark.apache.org/ or https://spark.apache.org/docs/latest/"
read -p "Which version of Spark would you like to install? " SPARK_VERSION
read -p "Which version of Java compatible with Spark would you like to install? " JAVA_VERSION

# Create the config folder. (CONFIG_FOLDER is exported from 'setup.sh'.)
if [ ! -d "$CONFIG_FOLDER" ]; then
    mkdir $CONFIG_FOLDER
fi

# Create the download folder. (DOWNLOAD_FOLDER is exported from 'setup.sh'.)
if [ ! -d "$DOWNLOAD_FOLDER" ]; then
    mkdir $DOWNLOAD_FOLDER
fi

# Update and save the env script to the config folder. (RESOURCES_FOLDER is exported from 'setup.sh'.)
sed -e "s/PYTHON_VERSION=/PYTHON_VERSION=$PYTHON_VERSION/g" \
    -e "s/R_VERSION=/R_VERSION=$R_VERSION/g" \
    -e "s/RSTUDIO_VERSION=/RSTUDIO_VERSION=$RSTUDIO_VERSION/g" \
    -e "s/SPARK_VERSION=/SPARK_VERSION=$SPARK_VERSION/g" \
    -e "s/JAVA_VERSION=/JAVA_VERSION=$JAVA_VERSION/g" \
    $RESOURCES_FOLDER/env.sh > $CONFIG_FOLDER/env.sh

# Create the vscode config folder. (VSCODE_CONFIG_FOLDER is exported from 'setup.sh'.)
if [ ! -d "$VSCODE_CONFIG_FOLDER" ]; then
    mkdir -p $VSCODE_CONFIG_FOLDER
fi

# Copy the settings file to the vscode config folder. (RESOURCES_FOLDER is exported from 'setup.sh'.)
cp $RESOURCES_FOLDER/settings.json $VSCODE_CONFIG_FOLDER/settings.json

# Create a symlink to setup.sh bash script.
sudo ln -fs $SRC_FOLDER/setup.sh /usr/local/bin/setup

# Install Git and set the username and user email.
sudo apt-get update
sudo apt-get -y install git
git config --global user.email "wonjae.lee.2@gmail.com"
git config --global user.name "Wonjae Lee"

# Generate a new SSH key.
ssh-keygen -q -t ed25519 -N "" -C "wonjae.lee.2@gmail.com" -f ~/.ssh/id_ed25519

# Display the new SSH key.
echo
echo "Add the key below to GitHub."
echo
cat ~/.ssh/id_ed25519.pub
echo
