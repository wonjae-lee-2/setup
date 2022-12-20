#!/bin/bash

# Check the latest version of Julia. https://julialang.org/

# Check if Juliaup exists already.
if command -v juliaup &> /dev/null
then
    echo
    echo "Juliaup already exists."
    exit 1
fi

# Install Julia using Juliaup. # https://github.com/JuliaLang/juliaup
curl -fsSL https://install.julialang.org | sh

# Create a symlink to Julia.
sudo ln -fs ~/.julia/juliaup/bin/julia /usr/local/bin/julia

# Show the installed Julia.
#juliaup status

#  Update Julia.
#juliaup self update
#juliaup update