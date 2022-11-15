#!/bin/bash

if [[ ! -f "/opt/cdn/lib/libtesseract3-maz-mock.so" ]]; then
    echo "Do NOT forget to use latest mocks of OCR engine used by image_to_text - see BUILD_MOCKS in cmaker.sh in i2t project"
fi
