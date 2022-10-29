#!/bin/bash

# Load software versions. (CONFIG_FOLDER is exported from 'vm.sh'.)
source $CONFIG_FOLDER/env.sh

# Get user input for software versions.
echo
echo "Python $PYTHON_VERSION is the current version in the env file."
echo "Check the latest version of Python. https://www.python.org/"
read -p "Which version of Python would you like to install? " NEW_PYTHON_VERSION
echo
echo ".NET SDK $DOTNET_VERSION is the current version in the env file."
echo "Check the latest version of .NET SDK. https://dotnet.microsoft.com/en-us/"
read -p "Which version of .NET SDK would you like to install? " NEW_DOTNET_VERSION
echo
echo "R $R_VERSION is the current version in the env file."
echo "Check the latest version of R. https://www.r-project.org/ https://docs.rstudio.com/resources/install-r/"
read -p "Which version of R would you like to install? " NEW_R_VERSION
echo
echo "RStudio $RSTUDIO_VERSION is the current version in the env file."
echo "Check the latest version of RStudio. https://www.rstudio.com/"
read -p "Which version of RStudio would you like to install? " NEW_RSTUDIO_VERSION
echo
echo "Spark $SPARK_VERSION is the current version in the env file."
echo "Java $JAVA_VERSION is the current version in the env file."
echo "Check the latest version of Spark. https://spark.apache.org/ https://spark.apache.org/docs/latest/"
read -p "Which version of Spark would you like to install? " NEW_SPARK_VERSION
read -p "Which version of Java compatible with Spark would you like to install? " NEW_JAVA_VERSION

# Update the env script.
sed -i \
    -e "s/PYTHON_VERSION=.*$/PYTHON_VERSION=$NEW_PYTHON_VERSION/g" \
    -e "s/DOTNET_VERSION=.*$/DOTNET_VERSION=$NEW_DOTNET_VERSION/g" \
    -e "s/R_VERSION=.*$/R_VERSION=$NEW_R_VERSION/g" \
    -e "s/RSTUDIO_VERSION=.*$/RSTUDIO_VERSION=$NEW_RSTUDIO_VERSION/g" \
    -e "s/SPARK_VERSION=.*$/SPARK_VERSION=$NEW_SPARK_VERSION/g" \
    -e "s/JAVA_VERSION=.*$/JAVA_VERSION=$NEW_JAVA_VERSION/g" \
    $CONFIG_FOLDER/env.sh

# Copy the docker compose file for the Jupyter Lab. (RESOURCES_FOLDER is exported from 'vm.sh'.)
cp $RESOURCES_FOLDER/compose.yaml ~/compose.yaml
