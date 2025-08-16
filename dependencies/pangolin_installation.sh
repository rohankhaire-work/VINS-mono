#!/bin/bash
set -e  # stop if any command fails

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
sudo ./scripts/install_prerequisites.sh recommended

# Configure, build, and install
cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local
cmake --build build -j$(nproc)
sudo cmake --install build

# Remove tar and ceres-bin
cd ..
rm -rf Pangolin
