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
sudo apt-get update
sudo apt-get -y install \
    wget \
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
    --enable-loadable-sqlite-extensions \
    --enable-optimizations \
    --enable-shared \
    --with-lto
make -s -j4 LDFLAGS="-Wl,-rpath,$INSTALL_FOLDER/lib"
sudo make install

# Delete the downloaded file and the build folder.
rm $DOWNLOAD_FOLDER/Python-$PYTHON_VERSION.tgz
sudo rm -r $BUILD_FOLDER

# Install poetry.
cd ~
curl -sSL https://install.python-poetry.org | $INSTALL_FOLDER/bin/python3 -

# Add poetry to PATH
echo "" >> ~/.profile
echo "# Add poetry to PATH" >> ~/.profile
echo "export PATH=\"/home/ubuntu/.local/bin:\$PATH\"" >> ~/.profile
