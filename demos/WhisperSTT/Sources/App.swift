import SwiftUI
import SwitchboardSDK
import SwitchboardSileroVAD
import SwitchboardWhisper

@main
struct SwitchboardiOSDemoApp: App {

    init() {
        SBSwitchboardSDK.initialize(withAppID: "demo", appSecret: "demo")
        SBSileroVADExtension.initialize(withConfig: [:])
        SBWhisperExtension.initialize(withConfig: [:])
    }

    var body: some Scene {
        WindowGroup {
            WhisperSTTExample()
        }
    }
}
