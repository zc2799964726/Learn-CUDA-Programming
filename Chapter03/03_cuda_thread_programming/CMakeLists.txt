cmake_minimum_required(VERSION 3.18)

project(cuda_thread_programming LANGUAGES CUDA CXX)

# Global standards
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 14)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

# Default CUDA architectures (match Makefiles' SMS lists)
if (CMAKE_CUDA_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0)
    set(CMAKE_CUDA_ARCHITECTURES 52;60;61;70;75;80)
else()
    set(CMAKE_CUDA_ARCHITECTURES 35;37;50;52;60;61;70;75)
endif()

# Option: build all examples (default ON)
option(BUILD_ALL_EXAMPLES "Build all subdirectory examples" ON)

# Discover and add subdirectories that contain a CMakeLists.txt
file(GLOB children RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*/")
foreach(child ${children})
    if(IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/${child}" AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${child}/CMakeLists.txt")
        if(BUILD_ALL_EXAMPLES)
            add_subdirectory(${child})
        else()
            message(STATUS "Skipping ${child} (BUILD_ALL_EXAMPLES=OFF)")
        endif()
    endif()
endforeach()

message(STATUS "Chapter03 top-level CMake: configured (BUILD_ALL_EXAMPLES=${BUILD_ALL_EXAMPLES})")
