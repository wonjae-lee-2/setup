#!/bin/bash

# Set folder paths.
export SRC_FOLDER=~/workspaces/setup/src
export COMMANDS_FOLDER=$SRC_FOLDER/commands
export RESOURCES_FOLDER=$SRC_FOLDER/resources
export CONFIG_FOLDER=~/.setup
export DOWNLOAD_FOLDER=~/downloads
export VSCODE_CONFIG_FOLDER=~/.vscode-server/data/Machine
export CURRENT_FOLDER=$(pwd)

# Run the script identified by positional arguments.
cd $COMMANDS_FOLDER/$1
bash $2.sh
