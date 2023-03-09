#!/bin/bash


case $THIRD_ARGUMENT in # THIRD_ARGUMENT is exported from 'setup.sh'.
    # Copy the python script template to the current directory. (CURRENT_FOLDER is exported from 'setup.sh'.)
    "script") cp -r $RESOURCES_FOLDER/templates/python/package/* $CURRENT_FOLDER
    ;;
esac