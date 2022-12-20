#!/bin/bash

# Set paths to initial directories.
DOWNLOAD_FOLDER=~/downloads
S3_FOLDER=~/s3
SECRET_FOLDER=~/secrets
VENV_FOLDER=~/venv
WORKSPACE_FOLDER=~/workspaces

# Stop entering password for the `sudo` command.
#sudo sed -i "s/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers

# Create initial directories.
mkdir $DOWNLOAD_FOLDER $S3_FOLDER $SECRET_FOLDER $VENV_FOLDER $WORKSPACE_FOLDER

# Install and configure Rclone for OneDrive and S3.
curl https://rclone.org/install.sh | sudo bash
rclone config
# Set the name of the remote as ondrive and s3.

# Test remote connections.
echo onedrive
rclone lsd onedrive:
echo s3
rclone lsd s3:

# Mount OneDrive and S3.
rclone mount onedrive:workspaces $WORKSPACE_FOLDER --daemon --file-perms 0777 --vfs-cache-mode full
rclone mount s3: $S3_FOLDER --daemon --vfs-cache-mode full

# Ensure Rclone mounts OneDrive and S3 if they are not mounted already at log in.
cat << EOF >> ~/.profile

# Ensure Rclone mounts OneDrive and S3 if they are not mounted already at log in.
if [ -z "\$(ls -A $WORKSPACE_FOLDER)" ]
then
    echo "Mounting OneDrive..."
    rclone mount onedrive:workspaces $WORKSPACE_FOLDER --daemon --file-perms 0777 --vfs-cache-mode full
fi
if [ -z "\$(ls -A $S3_FOLDER)" ]
then
    echo "Mounting S3..."
    rclone mount s3: $S3_FOLDER --daemon --vfs-cache-mode full
fi
EOF

# Install Git and set the username and user email.
sudo apt update
sudo apt install git
git config --global user.email "wonjae.lee.2@gmail.com"

# Generate a new SSH key.
ssh-keygen -t ed25519 # Select the default path and do not set any password.

# Display the new SSH key.
echo
echo "Add the key below to GitHub."
cat ~/.ssh/id_ed25519.pub
echo

# Copy the SSH private and public key to the `secrets` folder.
cp -t $SECRET_FOLDER ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
