cmake_minimum_required(VERSION 3.8)

project(KernelTest)

include_directories(include)

if(NOT DEFINED KERNEL_TARGET_LIB)
    set(KERNEL_TARGET_LIB "golden")
    message(STATUS "KERNEL_TARGET_LIB is not defined, using default kernel libary: ${KERNEL_TARGET_LIB}")
endif()

if (KERNEL_TARGET_LIB STREQUAL "golden")
    add_subdirectory(golden)
elseif(KERNEL_TARGET_LIB STREQUAL "inner")
    add_subdirectory(intrinsic_inner)
elseif(KERNEL_TARGET_LIB STREQUAL "dji")
    add_subdirectory(intrinsic_dji)
else()
    message(FATAL_ERROR "KERNEL_TARGET_LIB:${KERNEL_TARGET_LIB} isn't a known option: golden inner dji")
endif()

foreach(Kernel correlation psroi resize warp)
    add_executable(${Kernel} main/${Kernel}.c)
    target_link_libraries(${Kernel} kernels)
endforeach()


