# VINS-mono
VINS-mono without ROS dependency

# Dependencies
```bash
# Working dir -> VINS-mono
# Install opencv and Eigen using "apt install"
cd dependencies
./pangolin_installtion
./ceres_installation
```

# Build
``` bash
# Working dir -> VINS-mono
mkdir build && cd build
cmake ..
make
```

# Usage
``` bash
# The code is compiled in the build folder
# Working dir -> VINS-mono
# Image timestamps for EUROC can be found here -> https://github.com/heguixiang/EuRoc-Timestamps.git
./build/vins_estimator <path-to-config> <path to images OR .mp4 file> <image/video timestamps .txt> <imu data .csv>
```
