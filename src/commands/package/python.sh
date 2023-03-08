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

# Install Poetry and edit config.
curl -sSL https://install.python-poetry.org | /opt/python/$PYTHON_VERSION/bin/python3 -
~/.local/share/pypoetry/venv/bin/poetry config virtualenvs.in-project true

# Create a default virtual environment.
#/opt/python/$PYTHON_VERSION/bin/python3 -m venv $VENV_FOLDER

# Activate the virtiual environment.
#source $VENV_FOLDER/bin/activate

# Install package management tools.
/opt/python/$PYTHON_VERSION/bin/python3 -m pip install -U pip setuptools wheel

# Install and upgrade packages.
/opt/python/$PYTHON_VERSION/bin/python3 -m pip install -U -r $RESOURCES_FOLDER/requirements.txt

# Deactivate the virtual environment.
#deactivate
