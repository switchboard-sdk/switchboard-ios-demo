# SwitchboardiOSDemo

A simple Xcode-based speech-to-text and text-to-speech demo application for iOS.

## Setup

If dependencies are not included, do the following:

1. Create directory named `libs` in the project root.
2. Obtain/build and copy the following archives in `libs`:
    - `SwitchboardSDK.xcframework`
    - `SwitchboardOnnx.xcframework`
    - `SwitchboardSherpa.xcframework`
    - `SwitchboardWhisper.xcframework`
    - `SwitchboardSileroVAD.xcframework`
    - All the Whisper dependencies: `libggml*` and `libwhisper*`
    - SwitchboardSDK C++ include directory

## Build & Run

Open the `SwitchboardiOSDemo.xcworkspace` in Xcode.
Run the application.
