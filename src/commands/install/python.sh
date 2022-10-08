#!/bin/bash

# Load software versions. (CONFIG_FOLDER is exported from 'vm.sh'.)
source $CONFIG_FOLDER/env.sh

# Check if the same version exists already.
if [ -d /opt/python/$PYTHON_VERSION ]
then
    echo
    echo "Python $PYTHON_VERSION already exists."
    exit 1
fi

# Set folder paths. (DOWNLOAD_FOLDER is exported from 'vm.sh'.)
PYTHON_VERSION_SHORT=$(echo $PYTHON_VERSION | cut -d "." -f -2)
BUILD_FOLDER=$DOWNLOAD_FOLDER/python/$PYTHON_VERSION
INSTALL_FOLDER=/opt/python/$PYTHON_VERSION

# Install build dependencies. https://devguide.python.org/setup/#install-dependencies
sudo apt update
sudo apt install -y \
    build-essential \
    gdb \
    lcov \
    pkg-config \
    libbz2-dev \
    libffi-dev \
    libgdbm-dev \
    libgdbm-compat-dev \
    liblzma-dev \
    libncurses-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    lzma \
    lzma-dev \
    tk-dev \
    uuid-dev \
    zlib1g-dev

# Download Python from the official website.
cd $DOWNLOAD_FOLDER
wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz

# Extract the source file.
mkdir -p $BUILD_FOLDER
tar -x -f Python-$PYTHON_VERSION.tgz -C $BUILD_FOLDER --strip-components=1

# Install Python from source. https://github.com/docker-library/python
cd $BUILD_FOLDER
./configure \
    --prefix=$INSTALL_FOLDER \
    --enable-shared \
    --enable-optimizations \
    --with-lto \
    LDFLAGS=-Wl,-rpath,$INSTALL_FOLDER/lib
make -j -s
sudo make install

# Create a symlink to Python.
sudo ln -fs $INSTALL_FOLDER/bin/python$PYTHON_VERSION_SHORT /usr/local/bin/python

# Delete the downloaded file.
sudo rm $DOWNLOAD_FOLDER/Python-$PYTHON_VERSION.tgz
