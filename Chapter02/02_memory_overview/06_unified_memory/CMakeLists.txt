cmake_minimum_required(VERSION 3.18)

project(unified_memory_suite LANGUAGES CUDA CXX)

# Choose CUDA target architectures to match Makefile's SMS list
if (CMAKE_CUDA_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0)
    set(CMAKE_CUDA_ARCHITECTURES 52;60;61;70;75;80)
else()
    set(CMAKE_CUDA_ARCHITECTURES 35;37;50;52;60;61;70;75)
endif()

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 14)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

# Common include (Makefile referenced samples/common/inc)
if(DEFINED ENV{CUDA_PATH})
    set(CUDA_PATH $ENV{CUDA_PATH})
    if(EXISTS "${CUDA_PATH}/samples/common/inc")
        set(SAMPLES_COMMON_INC "${CUDA_PATH}/samples/common/inc")
    endif()
endif()

# Helper macro to create a CUDA-based executable with NVCC flags matching Makefile
macro(add_cuda_exe tgt src)
    add_executable(${tgt} ${src})
    target_include_directories(${tgt} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
    if(SAMPLES_COMMON_INC)
        target_include_directories(${tgt} PRIVATE ${SAMPLES_COMMON_INC})
    endif()
    # Match Makefile NVCC flags: -m64 -lineinfo
    target_compile_options(${tgt} PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:-m64 -lineinfo>)
endmacro()

# Create executables corresponding to Makefile targets
add_cuda_exe(unified_simple unified_memory.cu)
add_cuda_exe(unified_initialized unified_memory_initialized.cu)
add_cuda_exe(unified_prefetch unified_memory_prefetch.cu)
add_cuda_exe(unified_64align unified_memory_64align.cu)

# Optionally enable separable compilation if needed
# foreach(tgt IN ITEMS unified_simple unified_initialized unified_prefetch unified_64align)
#     set_target_properties(${tgt} PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
# endforeach()

# Done.
