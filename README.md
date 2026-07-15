# SwitchboardiOSDemo

A simple Xcode-based speech-to-text and text-to-speech demo application for iOS.

## Setup

No manual setup step is required. The Switchboard SDK and its extensions are declared as a
Swift Package Manager dependency
([switchboard-sdk-ios](https://github.com/switchboard-sdk/switchboard-sdk-ios), pinned to
**3.2.5**). Xcode resolves and downloads the packages automatically the first time you build.

> **Note:** the SwitchboardSDK Swift package vends all of its extensions as binary targets, so
> the first resolve downloads every artifact (a few GB in total) even though these demos only use
> a handful. Subsequent builds use the cached artifacts.

## Build & Run

Open `SwitchboardiOSDemo.xcworkspace` in Xcode, wait for package resolution to finish, then run
one of the demo schemes (WhisperSTT, SherpaTTS, or WhisperSTTtoSherpaTTS).
