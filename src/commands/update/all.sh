#!/bin/bash

# Load software versions.
source $CONFIG_FOLDER/env.sh

# Update Python.
bash ../install/python.sh
bash ../package/python.sh

# Update R.
bash ../install/r.sh
bash ../package/r.sh

# Update Julia.
juilaup self update
juliaup update
bash ../package/julia.sh

# Update Rust.
rustup update

# Update Kubectl.
gcloud components update

# Update Spark.
bash ../install/spark.sh

# Update Helm.
bash ../install/helm.sh

# Update .NET and Docker.
sudo apt update
sudo apt upgrade -y
