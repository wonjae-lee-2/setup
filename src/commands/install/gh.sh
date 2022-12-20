#/bin/bash

# Check if GitHub CLI exists already.
if command -v gh &> /dev/null
then
    echo
    echo "GitHub CLI already exists."
    exit 1
fi

# Install dependencies.
sudo apt update
sudo apt install -y --no-install-recommends curl

# Download the repository key.
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg

# Create the repository configuration.
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Install GitHub CLI from the repository.
sudo apt update
sudo apt install -y --no-install-recommends gh

# Authenticate with GitHub. Choose "Login with a web browser".
gh auth login
