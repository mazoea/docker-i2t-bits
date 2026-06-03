FROM ghcr.io/mazoea/docker-scanbuild:v18

# revert env from base image
ENV EXTCMD=
ENV CMAKE_CXX_COMPILER=/usr/bin/clang++-$CLANGVER \
    CMAKE_C_COMPILER=/usr/bin/clang-$CLANGVER

# The base scanbuild:v18 image ships an apt.kitware.com source whose signing key
# has since rotated, so `apt-get update` now fails with NO_PUBKEY. cmake is already
# installed in the base image, so the Kitware source is no longer needed here.
RUN rm -f /etc/apt/sources.list.d/kitware.list && \
    apt-get -q update && \
    apt-get -q install -y libc++abi-dev python3-dev && \
    rm -rf /var/lib/apt/lists/*

# copy
COPY assets/include /opt/cdn/include
COPY assets/lib /opt/cdn/lib
COPY assets/scripts /opt/scripts
COPY assets/packages/* /opt/

# build leptonica
ENV LEPTVER=1.78.0
RUN cd /opt/scripts && ./build_leptonica.sh

# check if we have OCR mocks
RUN cd /opt/scripts && ./check_mockers.sh

WORKDIR /opt/src/
CMD [ "clang", "--version" ]
