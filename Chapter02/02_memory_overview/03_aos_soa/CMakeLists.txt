cmake_minimum_required(VERSION 3.18)

project(aos_soa LANGUAGES CUDA CXX)

# CUDA architectures similar to Makefile's SMS list
if (CMAKE_CUDA_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0)
    set(CMAKE_CUDA_ARCHITECTURES 52;60;61;70;75;80)
else()
    set(CMAKE_CUDA_ARCHITECTURES 35;37;50;52;60;61;70;75)
endif()

set(CMAKE_CUDA_STANDARD 14)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

add_executable(aos aos.cu)
add_executable(soa soa.cu)

# Match Makefile's -lineinfo flag for CUDA compilation
foreach(tgt IN ITEMS aos soa)
    target_compile_options(${tgt} PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:-lineinfo>)
endforeach()

# Optionally add CUDA samples common include if present (as in the Makefile)
if(DEFINED ENV{CUDA_PATH})
    set(CUDA_PATH $ENV{CUDA_PATH})
    if(EXISTS "${CUDA_PATH}/samples/common/inc")
        target_include_directories(aos PRIVATE "${CUDA_PATH}/samples/common/inc")
        target_include_directories(soa PRIVATE "${CUDA_PATH}/samples/common/inc")
    endif()
endif()


