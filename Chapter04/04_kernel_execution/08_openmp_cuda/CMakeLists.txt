cmake_minimum_required(VERSION 3.18)
project(openmp_cuda_examples LANGUAGES CUDA CXX)

if (CMAKE_CUDA_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0)
    set(CMAKE_CUDA_ARCHITECTURES 52;60;61;70;75;80)
else()
    set(CMAKE_CUDA_ARCHITECTURES 35;37;50;52;60;61;70;75)
endif()

get_filename_component(SUBDIR_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)

macro(add_cuda_exe tgt srcs)
    set(pref_tgt ${SUBDIR_NAME}_${tgt})
    add_executable(${pref_tgt} ${srcs})
    target_include_directories(${pref_tgt} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
    # Host OpenMP flags and link libgomp for compatibility with Makefile behavior
    target_compile_options(${pref_tgt} PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:-m64 -lineinfo -rdc=true>)
    target_compile_options(${pref_tgt} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:-g -fopenmp>)
    target_link_libraries(${pref_tgt} PRIVATE -lgomp)
endmacro()

add_cuda_exe(openmp_default_stream openmp_default_stream.cu)
add_cuda_exe(openmp_gpus openmp_gpus.cu)
add_cuda_exe(openmp openmp.cu)
