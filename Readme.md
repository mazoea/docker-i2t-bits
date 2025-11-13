# Status

[![☃ build-and-publish](https://github.com/mazoea/docker-i2t-bits/actions/workflows/ci.yml/badge.svg?branch=mocks)](https://github.com/mazoea/docker-i2t-bits/actions/workflows/ci.yml)


# Depends on scanbuild docker image

Because of clang.

# How to (2019)

1. delete `assets/lib/*`
2. copy leptonica-1.78.0.tar.gz to `assets/packages/`
3. compile with clang
```
docker build -t te/cdn-clang-mock .
```
4. copy the library from `te/cdn-clang-mock`
```
cd ./assets
docker run --name tempik te/cdn-clang-mock /bin/true
docker cp tempik:lib/liblept.so lib/libleptonica1.so.1.78.0
docker rm tempik
## something like docker cp tempik:/opt/cdn/include/leptonica/*  include/leptonica/
```

5. build i2t mocks (see c-image-to-text/README.ci.md)
- first build fails - OK, we need the libtesseract* libs
- copy them to `./assets/lib`

# Create new release
`scripts\update.tag.bat`


===

# Recursive dependencies

1. leptonica will be built unless the `lib` directory contains the library and you can copy the built library back
```
cd image
docker run --name tempik te/cdn-clang-mock /bin/true
docker cp tempik:/opt/cdn/lib/libleptonica.so  lib/liblept.so
cp lib/liblept.so lib/libleptonica1.so.1.78.0
docker cp tempik:/opt/cdn/include/leptonica/*  include/leptonica/
docker stop tempik
```

2. check c-image-to-text/README.ci.md on how to build mocks