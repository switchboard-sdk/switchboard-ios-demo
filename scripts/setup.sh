#!/bin/bash

set -eu

PROJECT_DIR="$(git rev-parse --show-toplevel)"
PLATFORM="ios"
SDK_VERSION="release/3.2.2"
LIBS_DIR="${PROJECT_DIR}/libs"
TMP_DIR="${LIBS_DIR}/.tmp"

BASE_URL="https://switchboard-sdk-public.s3.amazonaws.com/builds/${SDK_VERSION}/${PLATFORM}"

# Packages whose zips have a flat layout: xcframework and include/ at root
FLAT_PACKAGES=(
    "SwitchboardSDK"
    "SwitchboardOnnx"
    "SwitchboardSherpa"
    "SwitchboardSileroVAD"
)

mkdir -p "${LIBS_DIR}" "${TMP_DIR}"

install_flat_package() {
    local PACKAGE_NAME="$1"
    local PKG_TMP="${TMP_DIR}/${PACKAGE_NAME}"
    rm -rf "${PKG_TMP}"
    mkdir -p "${PKG_TMP}"

    echo "Downloading ${PACKAGE_NAME}..."
    curl -fL -o "${PKG_TMP}/${PACKAGE_NAME}.zip" "${BASE_URL}/${PACKAGE_NAME}.zip"

    echo "Installing ${PACKAGE_NAME}..."
    unzip -q "${PKG_TMP}/${PACKAGE_NAME}.zip" -d "${PKG_TMP}"
    rm -rf "${LIBS_DIR}/${PACKAGE_NAME}.xcframework"
    cp -r "${PKG_TMP}/${PACKAGE_NAME}.xcframework" "${LIBS_DIR}/"
    if [ -d "${PKG_TMP}/include" ]; then
        cp -r "${PKG_TMP}/include/." "${LIBS_DIR}/include/"
    fi
    rm -rf "${PKG_TMP}"
}

install_whisper_package() {
    local PKG_TMP="${TMP_DIR}/SwitchboardWhisper"
    rm -rf "${PKG_TMP}"
    mkdir -p "${PKG_TMP}"

    echo "Downloading SwitchboardWhisper..."
    curl -fL -o "${PKG_TMP}/SwitchboardWhisper.zip" "${BASE_URL}/SwitchboardWhisper.zip"

    echo "Installing SwitchboardWhisper..."
    unzip -q "${PKG_TMP}/SwitchboardWhisper.zip" -d "${PKG_TMP}"
    rm -rf "${LIBS_DIR}/SwitchboardWhisper.xcframework"
    cp -r "${PKG_TMP}/Release/SwitchboardWhisper.xcframework" "${LIBS_DIR}/"
    rm -rf "${LIBS_DIR}/whisper.xcframework"
    cp -r "${PKG_TMP}/Release/lib/whisper.xcframework" "${LIBS_DIR}/"
    if [ -d "${PKG_TMP}/Release/include" ]; then
        cp -r "${PKG_TMP}/Release/include/." "${LIBS_DIR}/include/"
    fi
    rm -rf "${PKG_TMP}"
}

mkdir -p "${LIBS_DIR}/include"

for PACKAGE_NAME in "${FLAT_PACKAGES[@]}"; do
    install_flat_package "${PACKAGE_NAME}"
done
install_whisper_package

rm -rf "${TMP_DIR}"
echo "Done. libs/ is ready."
