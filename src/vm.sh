#!/bin/bash

# Set folder paths.
export SRC_FOLDER=~/workspaces/vm/src
export COMMANDS_FOLDER=$SRC_FOLDER/commands
export RESOURCES_FOLDER=$SRC_FOLDER/resources
export CONFIG_FOLDER=~/.vm
export DOWNLOAD_FOLDER=~/downloads

# Run the script identified by positional arguments.
cd $COMMANDS_FOLDER/$1
bash $2.sh
