#!/bin/bash

# Check the latest version of Julia. https://julialang.org/

# Check if Juliaup exists already.
if command -v juliaup &> /dev/null
then
    echo
    echo "Juliaup already exists."
    exit 1
fi

# Install dependencies.
sudo apt update
sudo apt install -y --no-install-recommends \
    curl \
    ca-certificates

# Install Julia using Juliaup. # https://github.com/JuliaLang/juliaup
curl -fsSL https://install.julialang.org | sh

# Add environmental variables to specify project folder and multi-threading.
echo "export JULIA_PROJECT=@." >> ~/.profile
echo "export JULIA_NUM_THREADS=auto" >> ~/.profile

# Show the installed Julia.
#juliaup status

#  Update Julia.
#juliaup self update
#juliaup update
