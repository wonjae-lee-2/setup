#!/bin/bash

# Load software versions. (CONFIG_FOLDER is exported from 'vm.sh'.)
source $CONFIG_FOLDER/env.sh

# Check if the same version exists already.
if [ -d /opt/spark/$SPARK_VERSION ]
then
    echo
    echo "Spark $SPARK_VERSION already exists."
    exit 1
fi

# Set environment variables.
R_VERSION_SHORT=$(echo $R_VERSION | cut -d "." -f -2)
INSTALL_FOLDER=/opt/spark/$SPARK_VERSION
ARCHITECTURE=$(uname -m)
if [ $ARCHITECTURE = "aarch64" ]
then
    SPARKLYR_FOLDER=~/venv/r/$R_VERSION/renv/library/R-$R_VERSION_SHORT/aarch64-unknown-linux-gnu/sparklyr/java
elif [ $ARCHITECTURE = "x86_64" ]
then
    SPARKLYR_FOLDER=~/venv/r/$R_VERSION/renv/library/R-$R_VERSION_SHORT/x86_64-pc-linux-gnu/sparklyr/java
fi

# Install Java runtime environment.
sudo apt update
sudo apt install -y --no-install-recommends openjdk-$JAVA_VERSION-jdk

# Download the Spark binary. (DOWNLOAD_FOLDER is exported from 'vm.sh'.)
cd $DOWNLOAD_FOLDER
wget https://dlcdn.apache.org/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop3.tgz

# Extract the binary file.
sudo mkdir -p $INSTALL_FOLDER
sudo tar -x -f spark-$SPARK_VERSION-bin-hadoop3.tgz -C $INSTALL_FOLDER --strip-components=1

# Copy sparklyr jar files for building docker images.
sudo mkdir $INSTALL_FOLDER/sparklyr
sudo cp $SPARKLYR_FOLDER/* $INSTALL_FOLDER/sparklyr

# Update the dockerfile to include sparklyr jar files.
sudo sed -i '/^COPY jars \/opt\/spark\/jars/a COPY sparklyr \/opt\/sparklyr' $INSTALL_FOLDER/kubernetes/dockerfiles/spark/Dockerfile

# Remove the downloaded file.
sudo rm $DOWNLOAD_FOLDER/spark-$SPARK_VERSION-bin-hadoop3.tgz
