#!/bin/bash

# Load software versions. (CONFIG_FOLDER is exported from 'vm.sh'.)
source $CONFIG_FOLDER/env.sh

# Check if the same version exists already.
if [ -d /opt/R/$R_VERSION ]
then
    echo
    echo "R $R_VERSION already exists."
    exit 1
fi

# Set folder paths. (DOWNLOAD_FOLDER is exported from 'vm.sh'.)
R_VERSION_SHORT=$(echo $R_VERSION | cut -d "." -f 1)
BUILD_FOLDER=$DOWNLOAD_FOLDER/R/$R_VERSION
INSTALL_FOLDER=/opt/R/$R_VERSION

# Install Java runtime environment. (JAVA_VERSION is exported from 'vm.sh'.)
sudo apt update
sudo apt install -y --no-install-recommends openjdk-$JAVA_VERSION-jdk

# Install build dependencies. Add libblas-dev, liblapack-dev, build-essential and gfortran. https://cloud.r-project.org/doc/manuals/r-release/R-admin.html#Useful-libraries-and-programs
sudo apt update
sudo apt install -y --no-install-recommends \
    libbz2-dev \
    libcairo2-dev \
    fontconfig \
    libfreetype-dev \
    libfribidi-dev \
    libglib2.0-dev \
    libharfbuzz-dev \
    libx11-dev \
    libxext-dev \
    libxt-dev \
    libcurl4-openssl-dev \
    libicu-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libtirpc-dev \
    libcrypt-dev \
    libncurses-dev \
    libpango1.0-dev \
    libpkgconf-dev \
    libpcre2-dev \
    libreadline-dev \
    tcl-dev \
    tk-dev \
    liblzma-dev \
    zlib1g-dev \
    libblas-dev \
    liblapack-dev \
    build-essential \
    gfortran

# Download R from CRAN.
cd $DOWNLOAD_FOLDER
wget https://cloud.r-project.org/src/base/R-$R_VERSION_SHORT/R-$R_VERSION.tar.gz

# Extract the source file.
mkdir -p $BUILD_FOLDER
tar -x -f R-$R_VERSION.tar.gz -C $BUILD_FOLDER --strip-components=1

# Install R from source. https://github.com/rocker-org/rocker-versioned2
cd $BUILD_FOLDER
./configure \
    --prefix=$INSTALL_FOLDER \
    --enable-R-shlib \
    --enable-memory-profiling \
    --with-blas \
    --with-lapack \
    --with-tcltk \
    --with-recommended-packages
make -j -s
sudo make install

# Create a symlink to R.
sudo ln -fs $INSTALL_FOLDER/bin/R /usr/local/bin/R
sudo ln -fs $INSTALL_FOLDER/bin/Rscript /usr/local/bin/Rscript

# Remove the downloaded file and the build folder.
sudo rm $DOWNLOAD_FOLDER/R-$R_VERSION.tar.gz
sudo rm -r $BUILD_FOLDER
