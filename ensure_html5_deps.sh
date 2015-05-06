#!/bin/bash
PLUGIN_PATH="$( cd "$( dirname "$0" )" && cd .. && pwd )"
pushd $PLUGIN_PATH

function run_or_fail {
    echo "Testing $@"
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "Command failed: $@ run in $(pwd)" 1>&2
        exit $status
    fi
    return $status
}
function abspath {
    pushd $1 > /dev/null
    local dirname=$(pwd)
    popd > /dev/null
    echo $dirname
}

if [ -z "$EMSDK_VERSION" ] ; then
    EMSDK_VERSION=sdk-1.30.0-64bit
fi

echo " -- Verifying that $EMSDK_VERSION is installed"
pushd emsdk_portable > /dev/null
run_or_fail ./emsdk update
run_or_fail ./emsdk install $EMSDK_VERSION
EMSDK_COUNT=$(ls emscripten | wc -l)
if [ $EMSDK_COUNT -ne 1 ] ; then
    echo " -- Too many versions of emsdk present; correcting"
    rm -Rf clang emscripten node
    run_or_fail ./emsdk install $EMSDK_VERSION
fi
popd > /dev/null

CMAKE_CMD=`which cmake`
if [ ! -x "$CMAKE_CMD" ] ; then
    echo " !! CMake not installed! Please install cmake!"
    exit 1;
fi

popd > /dev/null
