import SwiftUI
import SwitchboardSDK
import SwitchboardSileroVAD
import SwitchboardWhisper

@main
struct SwitchboardiOSDemoApp: App {

    init() {
        var extensionsConfig: [String: Any] = [:]

        // Whisper Extension
        SBWhisperExtension.loadExtension()
        extensionsConfig["Whisper"] = [:]

        // SileroVAD Extension
        SBSileroVADExtension.loadExtension()
        extensionsConfig["SileroVAD"] = [:]

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
            WhisperSTTExample()
        }
    }
}
