#!/bin/bash

# Load software versions.
source $CONFIG_FOLDER/env.sh

# Update Rclone.
rclone selfupdate

# Update AWS CLI.
bash awscli.sh

# Update Docker and GitHub CLI.
sudo apt update
sudo apt upgrade -y --no-install-recommends

# Update Google Cloud CLI.
#sudo snap refresh

# Update Python.
bash ../install/python.sh
bash ../package/python.sh

# Update R.
bash ../install/r.sh
bash ../package/r.sh

# Update RStudio.
bash ../install/rstudio.sh

# Update Spark.
bash ../install/spark.sh

# Update Julia.
juilaup self update
juliaup update
bash ../package/julia.sh

# Update Rust.
rustup update

# Update Helm.
#bash ../install/helm.sh

# Update Rclone plugin.
docker plugin disable rclone
docker plugin upgrade rclone
docker plugin enable rclone

