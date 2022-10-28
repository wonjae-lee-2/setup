#!/bin/bash

# Set environment variables.
JULIA_VERSION=$(julia --version | cut -d " " -f 3)
export PROJECT_FOLDER=~/venv/julia/$JULIA_VERSION

# Remove environment files.
if [ -d $PROJECT_FOLDER ]
then
    rm -r $PROJECT_FOLDER
fi

# Install packages in the project folder.
julia --project=$PROJECT_FOLDER $RESOURCES_FOLDER/requirements.jl

# Copy project files to the config folder.
cp -t $CONFIG_FOLDER/julia $PROJECT_FOLDER/Project.toml $PROJECT_FOLDER/Manifest.toml $PROJECT_FOLDER/spec-file.txt
