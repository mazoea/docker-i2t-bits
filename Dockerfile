FROM registry.gitlab.com/mazoea-team/docker-scanbuild:v6.0

# revert env from base image
ENV EXTCMD=
ENV CMAKE_CXX_COMPILER=/usr/bin/clang++-$CLANGVER \
    CMAKE_C_COMPILER=/usr/bin/clang-$CLANGVER

RUN apt-get -q update && \
    apt-get -q install -y libc++abi-dev python-dev && \
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
