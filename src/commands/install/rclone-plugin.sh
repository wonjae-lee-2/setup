#!/bin/bash

# Install dependencies.
sudo apt update
sudo apt-get -y install --no-install-recommends fuse

# Create two directories required by the plugin.
sudo mkdir -p /var/lib/docker-plugins/rclone/config
sudo mkdir -p /var/lib/docker-plugins/rclone/cache

# Copy the configuration file to whre the plugin can load it.
sudo cp ~/.config/rclone/rclone.conf /var/lib/docker-plugins/rclone/config

# Install the plugin.
sudo docker plugin install rclone/docker-volume-rclone:arm64 --alias rclone --grant-all-permissions args="-v --allow-other --vfs-cache-mode=full"
