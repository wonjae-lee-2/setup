#!/bin/bash

# Get user input for software versions.
echo
echo "Check the latest version of Python. https://www.python.org/"
read -p "Which version of Python would you like to install? " PYTHON_VERSION
echo
echo "Check the latest version of .NET SDK. https://dotnet.microsoft.com/en-us/"
read -p "Which version of .NET SDK would you like to install? " DOTNET_VERSION
echo
echo "Check the latest version of R. https://www.r-project.org/ https://docs.rstudio.com/resources/install-r/"
read -p "Which version of R would you like to install? " R_VERSION
echo
echo "Check the latest version of Spark. https://spark.apache.org/ https://spark.apache.org/docs/latest/"
read -p "Which version of Spark would you like to install? " SPARK_VERSION
read -p "Which version of Java compatible with Spark would you like to install? " JAVA_VERSION

# Create the config folder.
mkdir $CONFIG_FOLDER

# Update and save the env script to the config folder.
sed -e "s/PYTHON_VERSION=/PYTHON_VERSION=$PYTHON_VERSION/g" \
    -e "s/DOTNET_VERSION=/DOTNET_VERSION=$DOTNET_VERSION/g" \
    -e "s/R_VERSION=/R_VERSION=$R_VERSION/g" \
    -e "s/SPARK_VERSION=/SPARK_VERSION=$SPARK_VERSION/g" \
    -e "s/JAVA_VERSION=/JAVA_VERSION=$JAVA_VERSION/g" \
    ../../config/env.sh > $CONFIG_FOLDER/env.sh

# Create sub-folders.
mkdir $CONFIG_FOLDER/python
mkdir $CONFIG_FOLDER/r
mkdir $CONFIG_FOLDER/r/renv
mkdir $CONFIG_FOLDER/julia
