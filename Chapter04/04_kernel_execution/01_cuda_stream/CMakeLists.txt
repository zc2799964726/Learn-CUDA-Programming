cmake_minimum_required(VERSION 3.18)
project(cuda_stream_examples LANGUAGES CUDA CXX)

if (CMAKE_CUDA_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0)
    set(CMAKE_CUDA_ARCHITECTURES 52;60;61;70;75;80)
else()
    set(CMAKE_CUDA_ARCHITECTURES 35;37;50;52;60;61;70;75)
endif()

get_filename_component(SUBDIR_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)

macro(add_cuda_exe tgt src)
    set(pref_tgt ${SUBDIR_NAME}_${tgt})
    add_executable(${pref_tgt} ${src})
    target_include_directories(${pref_tgt} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
    target_compile_options(${pref_tgt} PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:-m64 -lineinfo>)
endmacro()

add_cuda_exe(default_stream 1_cuda_default_stream.cu)
add_cuda_exe(multi_stream 2_cuda_multi_stream.cu)
add_cuda_exe(multi_stream_sync 3_cuda_multi_stream_with_sync.cu)
add_cuda_exe(multi_stream_default 4_cuda_multi_stream_with_default.cu)
