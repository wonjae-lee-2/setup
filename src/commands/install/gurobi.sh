#!/bin/bash

# Download and extract the Gurobi Optimizer
cd $DOWNLOAD_FOLDER
wget https://packages.gurobi.com/10.0/gurobi10.0.0_armlinux64.tar.gz
sudo tar -xf gurobi10.0.0_armlinux64.tar.gz -C /opt

# Add environmental variables to the .profile file.
cat << EOF >> ~/.profile
export GUROBI_HOME="/opt/gurobi1000/armlinux64"
export PATH="\$PATH:\$GUROBI_HOME/bin"
export LD_LIBRARY_PATH="\$GUROBI_HOME/lib"
EOF

# Move the license file to the Gurobi folder.
sudo mv ~/gurobi.lic /opt/gurobi1000
