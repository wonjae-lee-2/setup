#!/bin/bash

# Set folder paths.
export SCRIPT_FOLDER=~/github/vm/src
export CONFIG_FOLDER=~/.vm
export DOWNLOAD_FOLDER=~/downloads

# Run the script identified by positional arguments.
cd $SCRIPT_FOLDER/commands/$1
bash $2.sh
