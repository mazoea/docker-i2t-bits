# Status

[![☃ build-and-publish](https://github.com/mazoea/docker-i2t-bits/actions/workflows/ci.yml/badge.svg?branch=mocks)](https://github.com/mazoea/docker-i2t-bits/actions/workflows/ci.yml)


# Depends on scanbuild docker image

Because of clang.

# How to (2019)

1. delete `image/lib/*`
2. copy leptonica-1.78.0.tar.gz to `image/packages/`
3. compile with clang
```
`cd ./image`
docker build -t te/cdn-clang-mock .
```
4. copy the library from `te/cdn-clang-mock`
```
cd `./image`
docker run --name tempik te/cdn-clang-mock /bin/true
cp lib/liblept.so lib/libleptonica1.so.1.78.0
## something like docker cp tempik:/opt/cdn/include/leptonica/*  include/leptonica/
docker stop tempik
```

5. build i2t mocks (see c-image-to-text/README.ci.md)
- first build fails - OK, we need the libtesseract* libs
- copy them to `./image/lib`

# Create new release
```
git push origin :mocks
git tag -d mocks
git tag mocks
git push origin mocks_source --tags
```


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