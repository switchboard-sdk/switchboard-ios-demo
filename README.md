# SwitchboardiOSDemo

A simple Xcode-based speech-to-text and text-to-speech demo application for iOS.

## Setup

No manual setup step is required. The Switchboard SDK and its extensions are declared as a
Swift Package Manager dependency
([switchboard-sdk-ios](https://github.com/switchboard-sdk/switchboard-sdk-ios), pinned to
**3.2.4**). Xcode resolves and downloads the packages automatically the first time you build.

> **Note:** the SwitchboardSDK Swift package vends all of its extensions as binary targets, so
> the first resolve downloads every artifact (a few GB in total) even though these demos only use
> a handful. Subsequent builds use the cached artifacts.

> **Temporary workaround (Whisper only):** the 3.2.4 SwiftPM package ships `SwitchboardWhisper`
> without its required `whisper.framework`, so the Whisper demos would otherwise crash at launch
> (`dyld: Library not loaded: @rpath/whisper.framework/whisper`). Before building **WhisperSTT** or
> **WhisperSTTtoSherpaTTS**, run this once to fetch the framework into `libs/` (git-ignored):
>
> ```sh
> ./scripts/fetch-whisper.sh
> ```
>
> Tracked in SWI-6658; once the SDK's SwiftPM package bundles whisper, delete `scripts/fetch-whisper.sh`,
> `libs/`, and the embed, and rely on SPM alone. (SherpaTTS needs no setup.)

## Build & Run

Open `SwitchboardiOSDemo.xcworkspace` in Xcode, wait for package resolution to finish, then run
one of the demo schemes (WhisperSTT, SherpaTTS, or WhisperSTTtoSherpaTTS).
