#!/bin/bash

# Load software versions. (CONFIG_FOLDER is exported from 'vm.sh'.)
source $CONFIG_FOLDER/env.sh

# Check if the same version of Python exists.
if [ ! -d /opt/python/$PYTHON_VERSION ]
then
    echo
    echo "Python $PYTHON_VERSION does not exist. Please install Python first."
    exit 1
fi

# Set the folder path.
VENV_FOLDER=~/venv/python/$PYTHON_VERSION

# Remove the existing virtual environment.
if [ -d $VENV_FOLDER ]
then
    rm -r $VENV_FOLDER
fi

# Create a new virtual environment.
python -m venv $VENV_FOLDER

# Activate the virtiual environment.
. $VENV_FOLDER/bin/activate

# Install package management tools.
pip install -U pip setuptools wheel

# Install and upgrade packages.
pip install -U -r ../../config/requirements.txt

# Create requirements.txt in the Python docker folder.
pip freeze --all > $CONFIG_FOLDER/python/requirements.txt

# Install the Chromium browser and dependencies.
playwright install chromium
playwright install-deps chromium

# Deactivate the virtual environment.
deactivate
