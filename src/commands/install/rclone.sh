#!/bin/bash

# Check if Rclone exists already.
if command -v rclone &> /dev/null
then
    echo
    echo "Rclone already exists."
    exit 1
fi

# Install dependencies.
sudo apt update
sudo apt install -y --no-install-recommends \
    curl \
    ca-certificates

# Install and configure Rclone for OneDrive and S3. Set the name of the remote as ondrive and s3.
curl https://rclone.org/install.sh | sudo bash
rclone config

# Create an executable command for syncing current directory to onedrive.
cat << EOF | sudo tee /usr/local/bin/backup
#!/bin/bash

DIRECTORY_PATH=\$(pwd)
DIRECTORY_NAME=\$(echo \$DIRECTORY_PATH | rev | cut -d "/" -f 1 | rev)
rclone sync --progress \$DIRECTORY_PATH onedrive:workspaces/\$DIRECTORY_NAME --exclude=/.venv/
EOF
sudo chmod +x /usr/local/bin/backup
