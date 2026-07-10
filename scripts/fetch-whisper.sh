#!/bin/bash

# Temporary workaround for SWI-6658.
#
# The SwitchboardSDK SwiftPM package (3.2.4) ships `SwitchboardWhisper` without its required
# `whisper.framework`, so the WhisperSTT and WhisperSTTtoSherpaTTS targets embed
# `whisper.xcframework` from `libs/` (git-ignored). This script fetches it. Everything else in
# the project is resolved via Swift Package Manager and needs no setup.
#
# Remove this script (and the libs/ embed) once the SDK's SwiftPM package bundles whisper.

set -eu

PROJECT_DIR="$(git rev-parse --show-toplevel)"
SDK_VERSION="release/3.2.4"
LIBS_DIR="${PROJECT_DIR}/libs"
TMP_DIR="${LIBS_DIR}/.tmp"
URL="https://switchboard-sdk-public.s3.amazonaws.com/builds/${SDK_VERSION}/ios/SwitchboardWhisper.zip"

if [ -d "${LIBS_DIR}/whisper.xcframework" ]; then
    echo "libs/whisper.xcframework already present — nothing to do. (Delete it to re-fetch.)"
    exit 0
fi

mkdir -p "${TMP_DIR}"
trap 'rm -rf "${TMP_DIR}"' EXIT

echo "Downloading whisper.xcframework (bundled in SwitchboardWhisper.zip)..."
curl -fL -o "${TMP_DIR}/SwitchboardWhisper.zip" "${URL}"

echo "Extracting..."
unzip -q "${TMP_DIR}/SwitchboardWhisper.zip" "Release/lib/whisper.xcframework/*" -d "${TMP_DIR}"
cp -R "${TMP_DIR}/Release/lib/whisper.xcframework" "${LIBS_DIR}/whisper.xcframework"

echo "Done. libs/whisper.xcframework is ready."
