import SwiftUI
import SwitchboardSDK
import SwitchboardSherpa
import SwitchboardSileroVAD
import SwitchboardWhisper

@main
struct SwitchboardiOSDemoApp: App {

    init() {
        SBSwitchboardSDK.initialize(withAppID: "demo", appSecret: "demo")
        SBSherpaExtension.initialize(withConfig: [:])
        SBSileroVADExtension.initialize(withConfig: [:])
        SBWhisperExtension.initialize(withConfig: [:])
    }

    var body: some Scene {
        WindowGroup {
            WhisperSTTtoSherpaTTSExample()
        }
    }
}
