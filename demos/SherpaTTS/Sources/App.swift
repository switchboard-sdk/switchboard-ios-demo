import SwiftUI
import SwitchboardSDK
import SwitchboardSherpa

@main
struct SwitchboardiOSDemoApp: App {

    init() {
        SBSwitchboardSDK.initialize(withAppID: "demo", appSecret: "demo")
        SBSherpaExtension.initialize(withConfig: [:])
    }

    var body: some Scene {
        WindowGroup {
            SherpaTTSExample()
        }
    }
}
