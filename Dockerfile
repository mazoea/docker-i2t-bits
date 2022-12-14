FROM ubuntu:16.04

ENV GCCVERSION=8

RUN apt-get -q update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q install -y software-properties-common build-essential && \
    rm -rf /var/lib/apt/lists/*

# gcc/g++
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get -q update  && \
    apt-get -q install -y wget curl gcc-$GCCVERSION g++-$GCCVERSION python python-dev && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$GCCVERSION 90 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-$GCCVERSION 90 && \
    DEBIAN_FRONTEND=noninteractive apt-get -q install -y zlib1g-dev liblzma-dev libffi-dev libssl-dev libsqlite3-dev libbz2-dev && \
    rm -rf /var/lib/apt/lists/*

# CMAKE
RUN wget https://github.com/Kitware/CMake/releases/download/v3.18.2/cmake-3.18.2-Linux-x86_64.sh -q -O /tmp/cmake-install.sh && \
    chmod u+x /tmp/cmake-install.sh && \
    mkdir /usr/bin/cmake && \
    /tmp/cmake-install.sh --skip-license --exclude-subdir --prefix=/usr/local/ && \
    rm /tmp/cmake-install.sh

RUN wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz -q -O /tmp/Python.tgz && \
    cd /tmp && tar -xvf ./Python.tgz && \
    cd Python-3.8.0 && \
    ./configure --enable-optimizations && \
    make -j8 && \
    make install

RUN g++ --version || true && \
    gcc --version || true && \
    cmake --version || true && \
    python --version && \
    python3 --version

# copy
COPY assets/include /opt/cdn/include
COPY assets/lib /opt/cdn/lib
RUN cd /opt/cdn/lib && \
    ln -s libtesseract4-maz.so.4.1.0 libtesseract4-maz.so && \
    ln -s libtesseract3-maz.so.3.0.2 libtesseract3-maz.so && \
    ln -s libleptonica1.so.1.78.0 libleptonica1.so && \
    ls -lah

ENV TE_LIBS=/opt/cdn

WORKDIR /opt/src/
CMD [ "g++", "--version" ]
