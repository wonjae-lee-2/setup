#!/bin/bash

# Check the latest version of .NET. https://dotnet.microsoft.com/en-us/

# Check if .NET exists already.
if command -v dotnet &> /dev/null
then
    echo
    echo ".NET already exists."
    exit 1
fi

# Load software versions. (CONFIG_FOLDER is exported from 'vm.sh'.)
source $CONFIG_FOLDER/env.sh

# Set the version variable.
DOTNET_VERSION_SHORT=$(echo $DOTNET_VERSION | cut -d "." -f -2)

# Install .NET SDK.
sudo apt update
sudo apt install -y dotnet-sdk-$DOTNET_VERSION_SHORT
