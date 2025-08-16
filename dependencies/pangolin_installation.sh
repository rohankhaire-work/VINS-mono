1#!/bin/bash
set -e  # stop if any command fails
CXX_FLAGS=""

# If running as root, don't use sudo; otherwise, use sudo
if [ "$EUID" -eq 0 ]; then
    SUDO=""
else
    SUDO="sudo"
fi

. /etc/os-release
if [ "$VERSION_ID" = "20.04" ]; then
    CXX_FLAGS="-Wno-deprecated-copy"
fi

# Python wheel dependencies
python3 -m pip install --upgrade pip
python3 -m pip install wheel setuptools

##############################
##### PANGOLIN ###############
##############################
if [ ! -d Pangolin ]; then
    git clone --recursive https://github.com/stevenlovegrove/Pangolin.git
fi

cd Pangolin
./scripts/install_prerequisites.sh required

# Configure, build, and install
cmake -B build -DCMAKE_BUILD_TYPE=Release \
               -DCMAKE_INSTALL_PREFIX=/usr/local \
               -DCMAKE_CXX_FLAGS="$CXX_FLAGS"
cmake --build build -j$(nproc)
$SUDO cmake --install build
$SUDO ldconfig

# Remove tar and ceres-bin
cd ..
rm -rf Pangolin
