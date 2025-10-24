cmake_minimum_required(VERSION 3.18)

project(sgemm LANGUAGES CUDA CXX)

# CUDA architectures similar to Makefile's SMS list
if (CMAKE_CUDA_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0)
    set(CMAKE_CUDA_ARCHITECTURES 52;60;61;70;75;80)
else()
    set(CMAKE_CUDA_ARCHITECTURES 35;37;50;52;60;61;70;75)
endif()

set(CMAKE_CUDA_STANDARD 14)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

add_executable(sgemm sgemm.cu)

# Match Makefile's -lineinfo flag for CUDA compilation
target_compile_options(sgemm PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:-lineinfo>)

# Optionally add CUDA samples common include if present (as in the Makefile)
if(DEFINED ENV{CUDA_PATH})
    set(CUDA_PATH $ENV{CUDA_PATH})
    if(EXISTS "${CUDA_PATH}/samples/common/inc")
        target_include_directories(sgemm PRIVATE "${CUDA_PATH}/samples/common/inc")
    endif()
endif()


