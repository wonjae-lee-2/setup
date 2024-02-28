#!/bin/bash

# GPU spec https://www.nvidia.com/en-us/data-center/tesla-t4/
# Compatible CUDA driver and toolkit version https://docs.nvidia.com/datacenter/tesla/drivers/index.html#cuda-arch-matrix
# CUDA installation guide https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html
# PyTorch installation guide https://pytorch.org/get-started/locally/
# Install CUDA toolkit and cuDNN versions in the latest PyTorch image https://hub.docker.com/r/pytorch/pytorch

MY_DIST="ubuntu2204"
MY_ARCH="sbsa"
MY_DRIVER="550"
MY_CUDA="cuda-toolkit-12-1"
MY_CUDA_PATH="/usr/local/cuda-12.1/bin"
MY_CUDNN="libcudnn8-dev"

# Install packages needed for installation
sudo apt update
sudo apt -y install \
    wget \
    curl

# Install nvidia drivers, CUDA and cuDNN
sudo apt -y install gcc-12
sudo apt -y install linux-headers-$(uname -r)
sudo apt-key del 7fa2af80
wget https://developer.download.nvidia.com/compute/cuda/repos/${MY_DIST}/${MY_ARCH}/cuda-archive-keyring.gpg
sudo mv cuda-archive-keyring.gpg /usr/share/keyrings/cuda-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/${MY_DIST}/${MY_ARCH}/ /" | \
    sudo tee /etc/apt/sources.list.d/cuda-${MY_DIST}-${MY_DIST}.list
wget https://developer.download.nvidia.com/compute/cuda/repos/${MY_DIST}/${MY_ARCH}/cuda-${MY_DIST}.pin
sudo mv cuda-${MY_DIST}.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt update
sudo apt -y install cuda-drivers-${MY_DRIVER}
sudo apt -y install ${MY_CUDA}
sudo apt -y install ${MY_CUDNN}

# Add CUDA toolkit to PATH at login
echo "" >> /home/ubuntu/.profile
echo "# Add CUDA toolkit to PATH" >> /home/ubuntu/.profile
echo "export PATH=\"${MY_CUDA_PATH}:\$PATH\"" >> /home/ubuntu/.profile

# Install NVIDIA Container Toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
    sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update
sudo apt install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
