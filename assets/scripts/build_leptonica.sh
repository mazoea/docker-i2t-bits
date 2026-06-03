#!/bin/bash
# env LEPTVER=1.76.0
set -e

# The repo ships the prebuilt lib as libleptonica1.so (see assets/lib); only build
# from source when it is missing. (The old guard checked for liblept.so, a name no
# longer produced, so leptonica was rebuilt on every image build.)
if [[ ! -f "/opt/cdn/lib/libleptonica1.so" ]]; then
    cd /opt 
    tar xvzf leptonica-$LEPTVER.tar.gz
    cd leptonica-$LEPTVER
    mkdir build
    cd build
    cmake ..
    make -j4
    cp -f src/libleptonica* /opt/cdn/lib/
    mkdir -p /opt/cdn/include/leptonica/ || true
    cp -f src/*.h /opt/cdn/include/leptonica/
fi
