#!/bin/bash

# Set folder paths.
export SRC_FOLDER=~/efs/setup/src
export COMMANDS_FOLDER=$SRC_FOLDER/commands
export RESOURCES_FOLDER=$SRC_FOLDER/resources
export CONFIG_FOLDER=~/.setup
export DOWNLOAD_FOLDER=~/download
export VSCODE_CONFIG_FOLDER=~/.vscode-server/data/Machine
export CURRENT_FOLDER=$(pwd)

# Run the script identified by positional arguments.
export THIRD_ARGUMENT=$3
cd $COMMANDS_FOLDER/$1
bash $2.sh
