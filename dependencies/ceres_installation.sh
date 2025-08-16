#!/bin/bash
set -e  # stop if any command fails
CMAKE_FLAGS=""

# If running as root, don't use sudo; otherwise, use sudo
if [ "$EUID" -eq 0 ]; then
    SUDO=""
else
    SUDO="sudo"
fi

. /etc/os-release
if [ "$VERSION_ID" = "22.04" ]; then
    CMAKE_FLAGS="-DSUITESPARSE=OFF -DBUILD_TESTING=OFF"
fi

#######################
#### DEPENDENCIES #####
#######################
$SUDO apt update
$SUDO apt install -y \
    wget \
    cmake \
    libgflags-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libtbb-dev \
    libunwind-dev \
    libgoogle-glog-dev

##############################
##### CERES ##################
##############################
# Download Ceres tarball if not already present
if [ ! -f ceres-solver-1.14.0tar.gz ]; then
    $SUDO wget https://github.com/ceres-solver/ceres-solver/archive/refs/tags/1.14.0.tar.gz -O ceres-solver-1.14.0.tar.gz
fi

# Extract
tar zxf ceres-solver-1.14.0.tar.gz
mkdir -p ceres-bin
cd ceres-bin

# Configure and build
cmake ../ceres-solver-1.14.0 $CMAKE_FLAGS 
make -j$(nproc)
make test || true   # don't fail if some tests break
$SUDO make install

# Remove tar and ceres-bin
cd ..
rm -rf ceres-solver-1.14.0.tar.gz ceres-bin ceres-solver-1.14.0
