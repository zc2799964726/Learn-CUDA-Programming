cmake_minimum_required(VERSION 3.18)

project(image_scaling LANGUAGES CUDA CXX)

# Match Makefile's list of target GPU architectures (SMS). If CUDA 11+, use the 11.x set.
if (CMAKE_CUDA_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0)
    set(CMAKE_CUDA_ARCHITECTURES 52;60;61;70;75;80)
else()
    set(CMAKE_CUDA_ARCHITECTURES 35;37;50;52;60;61;70;75)
endif()

# Use C++14 / CUDA 14 where appropriate (keep parity with other chapters)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 14)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

# Source files (Makefile used NVCC to compile both .cu and .cpp)
add_executable(image_scaling image_scaling.cu scrImagePgmPpmPackage.cpp)

# Provide the local include directory for the header (scrImagePgmPpmPackage.h)
target_include_directories(image_scaling PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

# Add CUDA samples common include if present (Makefile used ${CUDA_PATH}/samples/common/inc)
if(DEFINED ENV{CUDA_PATH})
    set(CUDA_PATH $ENV{CUDA_PATH})
    if(EXISTS "${CUDA_PATH}/samples/common/inc")
        target_include_directories(image_scaling PRIVATE "${CUDA_PATH}/samples/common/inc")
    endif()
endif()

# Match Makefile NVCC flags: -m64 -lineinfo (used for profiling/line info)
# and keep it only for CUDA compilation
target_compile_options(image_scaling PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:-m64 -lineinfo>)

# For the project we rely on CMake's CMAKE_CUDA_ARCHITECTURES instead of echoing gencode flags.
# The target will be built with the architectures chosen above.

# Optionally set more CUDA-specific target properties here if needed
# e.g. set_target_properties(image_scaling PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

# Done.
