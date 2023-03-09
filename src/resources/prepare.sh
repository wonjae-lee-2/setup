#!/bin/bash

# Set paths to initial directories.
DOWNLOAD_FOLDER=~/downloads
VENV_FOLDER=~/venv
WORKSPACE_FOLDER=~/workspaces

# Stop entering password for the `sudo` command.
#sudo sed -i "s/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers

# Create initial directories.
mkdir $DOWNLOAD_FOLDER $VENV_FOLDER $WORKSPACE_FOLDER

# Mount OneDrive and S3.
#rclone mount onedrive:workspaces $WORKSPACE_FOLDER --daemon --file-perms 0777 --vfs-cache-mode full
#rclone mount s3: $S3_FOLDER --daemon --vfs-cache-mode full

# Ensure Rclone mounts OneDrive and S3 if they are not mounted already at log in.
#cat << EOF >> ~/.profile
#
## Ensure Rclone mounts OneDrive and S3 if they are not mounted already at log in.
#if [ -z "\$(ls -A $WORKSPACE_FOLDER)" ]
#then
#    echo "Mounting OneDrive..."
#    rclone mount onedrive:workspaces $WORKSPACE_FOLDER --daemon --file-perms 0777 --vfs-cache-mode full
#fi
#if [ -z "\$(ls -A $S3_FOLDER)" ]
#then
#    echo "Mounting S3..."
#    rclone mount s3: $S3_FOLDER --daemon --vfs-cache-mode full
#fi
#EOF

# Install Git and set the username and user email.
sudo apt update
sudo apt install git
git config --global user.email "wonjae.lee.2@gmail.com"
git config --global user.name "Wonjae Lee"

# Generate a new SSH key.
ssh-keygen -t ed25519 # Select the default path and do not set any password.

# Display the new SSH key.
echo
echo "Add the key below to GitHub."
echo
cat ~/.ssh/id_ed25519.pub
echo
read -s -p $'Press any key to continue...\n'

# Clone the setup repo from GitHub.
cd $WORKSPACE_FOLDER
git clone git@github.com:wonjae-lee-2/setup
