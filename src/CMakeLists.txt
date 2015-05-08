# Written to work with cmake 2.6
cmake_minimum_required (VERSION 2.6)
set (CMAKE_BACKWARDS_COMPATIBILITY 2.6)
SET(CMAKE_EXECUTABLE_SUFFIX ".js")

project(emsdk_test)

set(EMCC_FLAGS "-O3 -ftree-vectorize -Wno-warn-absolute-paths -Werror -s EXPORTED_FUNCTIONS=\"['test1','testBuffer','getVersion']\"")

set(CMAKE_C_FLAGS ${EMCC_FLAGS})
set(CMAKE_CXX_FLAGS ${EMCC_FLAGS})

set(Boost_INCLUDE_DIRS ${BOOST_ROOT})
set(Boost_LIBRARY_DIR ${BOOST_ROOT}/stage/lib)

file (GLOB GENERAL RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    [^.]*.cpp
    [^.]*.h
    [^.]*.cmake
    )

add_definitions(-DEMSCRIPTEN)
if (NOT VERSION)
    set(VERSION '2.0.0.0')
endif()
add_definitions(-DVERSION=\"${VERSION}\")

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/test.html ${CMAKE_CURRENT_BINARY_DIR}/test.html)

# Generated files are stored in ${GENERATED} by the project configuration
SET_SOURCE_FILES_PROPERTIES(
    ${GENERATED}
    PROPERTIES
        GENERATED 1
    )

SOURCE_GROUP(Generated FILES
    ${GENERATED}
    )

SET( SOURCES
    ${GENERAL}
    ${GENERATED}
    )

add_library(emsdk_test SHARED ${SOURCES})
message("Using ${SOURCES}")

set_target_properties(emsdk_test PROPERTIES
    SUFFIX .js
    LINK_FLAGS ${EMCC_FLAGS})

