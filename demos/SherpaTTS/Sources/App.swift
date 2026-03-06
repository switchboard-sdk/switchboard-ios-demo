import SwiftUI
import SwitchboardSDK
import SwitchboardSherpa

@main
struct SwitchboardiOSDemoApp: App {

    init() {
        var extensionsConfig: [String: Any] = [:]

        // Sherpa Extension
        SBSherpaExtension.loadExtension()
        extensionsConfig["Sherpa"] = [:]

        // Init SDK
        let initConfig: [String: Any] = [
            "appID": "demo",
            "appSecret": "demo",
            "extensions": extensionsConfig,
        ]
        let result = Switchboard.initialize(withConfig: initConfig)
        if !result.success {
            fatalError("Switchboard SDK initialization failed.")
        }
    }

    var body: some Scene {
        WindowGroup {
            SherpaTTSExample()
        }
    }
}
