#!/bin/bash

# Set folder paths.
export COMMANDS_FOLDER=~/github/vm/src/commands
export RESOURCES_FOLDER=~/github/vm/src/resources
export CONFIG_FOLDER=~/.vm
export DOWNLOAD_FOLDER=~/downloads

# Run the script identified by positional arguments.
cd $COMMANDS_FOLDER/$1
bash $2.sh
