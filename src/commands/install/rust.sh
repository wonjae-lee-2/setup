#!/bin/bash

# Check the latest version of Rust. https://www.rust-lang.org/

# Check if Juliaup exists already.
if command -v rustup &> /dev/null
then
    echo
    echo "Rustup already exists."
    exit 1
fi

# Install Rust using Rustup. https://github.com/rust-lang/rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Show the active and installed toolchains or profiles.
#rustup show

# Update Rust.
#rustup update
