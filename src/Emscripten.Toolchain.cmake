include( CMakeForceCompiler )

set( EMSCRIPTEN                 ON )
set( PCH_DISABLE                ON )

set( PLATFORM_EMBEDDED          ON )
set( PLATFORM_NAME              "Emscripten" )
set( PLATFORM_TRIPLET           "emscripten" )
set( PLATFORM_PREFIX            "${EMSCRIPTEN_ROOT}" )
set( PLATFORM_EXE_SUFFIX        ".js" )

set( CMAKE_SYSTEM_NAME          "Generic" CACHE STRING "Target system." )
set( CMAKE_SYSTEM_PROCESSOR     "JavaScript" CACHE STRING "Target processor." )
set( CMAKE_C_COMPILER           "${PLATFORM_PREFIX}/emcc" )
set( CMAKE_CXX_COMPILER         "${PLATFORM_PREFIX}/em++" )
set( CMAKE_C_FLAGS              "-Qunused-arguments -U__STRICT_ANSI__" CACHE STRING "" )
set( CMAKE_CXX_FLAGS            "-Qunused-arguments -U__STRICT_ANSI__" CACHE STRING "" )
set( CMAKE_C_FLAGS_RELEASE      "-O2" CACHE STRING "" )
set( CMAKE_CXX_FLAGS_RELEASE    "-O2" CACHE STRING "" )
set( CMAKE_C_ARCHIVE_CREATE     "${CMAKE_C_COMPILER} -o <TARGET> -emit-llvm <LINK_FLAGS> <OBJECTS>" )
set( CMAKE_CXX_ARCHIVE_CREATE   "${CMAKE_CXX_COMPILER} -o <TARGET> -emit-llvm <LINK_FLAGS> <OBJECTS>" )
set( CMAKE_AR                   "${PLATFORM_PREFIX}/emar")
set( CMAKE_RANLIB               "${PLATFORM_PREFIX}/emranlib")

set( CMAKE_LINK_LIBRARY_SUFFIX ".a.bc" )
set( CMAKE_STATIC_LIBRARY_SUFFIX ".a.bc")

cmake_force_c_compiler(         ${CMAKE_C_COMPILER} Clang )
cmake_force_cxx_compiler(       ${CMAKE_CXX_COMPILER} Clang )

set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
set( CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY )
