cmake_minimum_required(VERSION 3.18)

project(warp_and_thread_block LANGUAGES CUDA CXX)

# Match Makefile's SMS list via CMake's CUDA architectures
if (CMAKE_CUDA_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0)
    set(CMAKE_CUDA_ARCHITECTURES 52;60;61;70;75;80)
else()
    set(CMAKE_CUDA_ARCHITECTURES 35;37;50;52;60;61;70;75)
endif()

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 14)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

# Add executable corresponding to Makefile target
add_executable(cuda_thread_block cuda_thread_block.cu)

# Add local include dir and optional CUDA samples common include
target_include_directories(cuda_thread_block PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
if(DEFINED ENV{CUDA_PATH})
    set(CUDA_PATH $ENV{CUDA_PATH})
    if(EXISTS "${CUDA_PATH}/samples/common/inc")
        target_include_directories(cuda_thread_block PRIVATE "${CUDA_PATH}/samples/common/inc")
    endif()
endif()

# Match NVCC flags from Makefile (-m64 -lineinfo)
target_compile_options(cuda_thread_block PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:-m64 -lineinfo>)

# Done.
