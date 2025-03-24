cmake_minimum_required(VERSION 3.16)

# Set project name and language
project(OMPEval VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Set compiler flags
if(MSVC)
    add_compile_options(/std:c++17 /W4)
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        add_compile_options(/MDd)
    else()
        add_compile_options(/O2 /MD)
    endif()
else()
    add_compile_options(-O3 -std=c++17 -Wall -Wpedantic)
endif()

# Find Threads library
find_package(Threads REQUIRED)

# Add SSE4 flag if needed
if(SSE4)
    add_compile_definitions(SSE4_ENABLED)
    add_compile_options(-msse4.2)
endif()

# Include the directories for the source code
include_directories(omp)

# Set source files
file(GLOB SRCS "omp/*.cpp")

# Add the library target
add_library(ompeval SHARED ${SRCS})

# Add the test executable
add_executable(test test.cpp benchmark.cpp)

# Link the library and threads to the test executable
target_link_libraries(test ompeval Threads::Threads)

# Set Visual Studio startup project (only relevant for VS users)
if(MSVC)
    set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT test)
endif()

# Install the library and headers to default directories (if needed)

install(TARGETS ompeval DESTINATION bin)
install(FILES $<TARGET_FILE:ompeval> DESTINATION bin)

# Install the headers from the 'omp' directory into 'include'
install(DIRECTORY omp/ DESTINATION ${CMAKE_INSTALL_PREFIX}/include FILES_MATCHING PATTERN "*.h")