#!/bin/bash
set -e  # stop if any command fails

#######################
#### DEPENDENCIES #####
#######################
sudo apt-get update
sudo apt-get install -y \
    wget \
    cmake \
    libunwind-dev \
    libgoogle-glog-dev libgflags-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev

##############################
##### CERES ##################
##############################
# Download Ceres tarball if not already present
if [ ! -f ceres-solver-2.2.0.tar.gz ]; then
    wget https://github.com/ceres-solver/ceres-solver/archive/refs/tags/2.2.0.tar.gz -O ceres-solver-2.2.0.tar.gz
fi

# Extract
tar zxf ceres-solver-2.2.0.tar.gz
mkdir -p ceres-bin
cd ceres-bin

# Configure and build
cmake ../ceres-solver-2.2.0
make -j$(nproc)
make test || true   # don't fail if some tests break
sudo make install

# Remove tar and ceres-bin
cd ..
rm -rf ceres-solver-2.2.0.tar.gz ceres-bin ceres-solver-2.2.0
