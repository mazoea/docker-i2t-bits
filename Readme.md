# How to build i2t under windows using this Docker image

oneliner
```
docker run --rm -it -e TE_LIBS=/opt/cdn -v d:\te\c-image-to-text:/opt/src registry.gitlab.com/mazoea-team/docker-i2t-bits:latest ./cmaker.sh 6
```

with bash
```
docker run --rm -it -e TE_LIBS=/opt/cdn -v d:\te\c-image-to-text:/opt/src registry.gitlab.com/mazoea-team/docker-i2t-bits:latest /bin/bash
./cmaker.sh  6
```


# How to update from te-binaries

```

cp ./te-external-tesseract/tesseract/mazapi/ocrlib_tesseract3.h ./docker-i2t-bits/image/include/tesseract3-maz/
cp ./te-external-tesseract4/tesseract/src/mazapi/ocrlib_tesseract4.h ./docker-i2t-bits/image/include/tesseract4-maz/
cp ./te-binaries/libtesseract3-maz.so.3.0.2 ./te-binaries/libtesseract4-maz.so.4.1.0 ./docker-i2t-bits/image/lib/

git commit -am "XXX"

git push origin :latest
git tag -d latest
git tag latest
git push origin master --tags
```
or
```
git push origin :v8
git tag -d v8
git tag v8
git push origin v8_source --tags
```

## Recursive dependencies

1. leptonica will be built unless the `lib` directory contains the library and you can copy the built library back
```
cd image
docker run --name tempik te/cdn-clang-mock /bin/true
docker cp tempik:/opt/cdn/lib/libleptonica.so  lib/liblept.so
cp lib/liblept.so lib/libleptonica.so.5.3.0
docker cp tempik:/opt/cdn/include/leptonica/*  include/leptonica/
docker stop tempik
```