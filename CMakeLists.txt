cmake_minimum_required(VERSION 3.15)
project(vins_estimator)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_CXX_FLAGS "-std=c++11")
#-DEIGEN_USE_MKL_ALL")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -Wall -g -pthread -fopenmp")

find_package(Eigen3 3.3 REQUIRED NO_MODULE)
find_package(Ceres REQUIRED)
find_package(Boost REQUIRED COMPONENTS filesystem program_options system)
find_package(Pangolin REQUIRED)

add_executable(vins_estimator
    src/estimator_node.cpp
    src/parameters.cpp
    src/estimator.cpp
    src/feature_manager.cpp
    src/factor/pose_local_parameterization.cpp
    src/factor/projection_factor.cpp
    src/factor/marginalization_factor.cpp
    src/utility/utility.cpp
    src/utility/visualization.cpp
    src/initial/solve_5pts.cpp
    src/initial/initial_aligment.cpp
    src/initial/initial_sfm.cpp
    src/initial/initial_ex_rotation.cpp
    src/loop-closure/ThirdParty/DBoW/BowVector.cpp
    src/loop-closure/ThirdParty/DBoW/FBrief.cpp
    src/loop-closure/ThirdParty/DBoW/FeatureVector.cpp
    src/loop-closure/ThirdParty/DBoW/QueryResults.cpp
    src/loop-closure/ThirdParty/DBoW/ScoringObject.cpp
    src/loop-closure/ThirdParty/DUtils/Random.cpp
    src/loop-closure/ThirdParty/DUtils/Timestamp.cpp
    src/loop-closure/ThirdParty/DVision/BRIEF.cpp
    src/loop-closure/ThirdParty/VocabularyBinary.cpp
    src/loop-closure/loop_closure.cpp
    src/loop-closure/keyframe.cpp
    src/loop-closure/keyframe_database.cpp
    src/feature_tracker/feature_tracker.cpp 
    src/camera_model/chessboard/Chessboard.cc
    src/camera_model/calib/CameraCalibration.cc
    src/camera_model/camera_models/Camera.cc
    src/camera_model/camera_models/CameraFactory.cc
    src/camera_model/camera_models/CostFunctionFactory.cc
    src/camera_model/camera_models/PinholeCamera.cc
    src/camera_model/camera_models/CataCamera.cc
    src/camera_model/camera_models/EquidistantCamera.cc
    src/camera_model/camera_models/ScaramuzzaCamera.cc
    src/camera_model/sparse_graph/Transform.cc
    src/camera_model/gpl/gpl.cc
    src/camera_model/gpl/EigenQuaternionParameterization.cc
    )

target_include_directories(vins_estimator PRIVATE src
                                                  src/rosmsg_headers
                                                  ${OpenCV_INCLUDE_DIRS}
                                                  ${PANGOLIN_INCLUDE_DIR} 
                                                  ${CERES_INCLUDE_DIRS})


target_link_libraries(vins_estimator Eigen3::Eigen
                                     ${OpenCV_LIBS}
                                     ${Pangolin_LIBRARIES}
                                     ${CERES_LIBRARIES}) 


