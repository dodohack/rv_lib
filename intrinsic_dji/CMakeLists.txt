file(GLOB SRC "./*.c" "./*.cpp")

add_library(kernels STATIC ${SRC})
