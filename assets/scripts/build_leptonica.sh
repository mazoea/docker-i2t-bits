#!/bin/bash
# env LEPTVER=1.76.0

if [[ ! -f "/opt/cdn/lib/liblept.so" ]]; then 
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
