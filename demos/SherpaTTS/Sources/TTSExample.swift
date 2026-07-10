//
//  TTSExample.swift
//  SwitchboardiOSDemo
//

import Foundation
import SwitchboardSDK

class TTSExample {
    private var engineID: String?

    func createEngine() {
        guard let path = Bundle.main.path(forResource: "TTSExample", ofType: "json"),
              let json = try? String(contentsOfFile: path, encoding: .utf8)
        else {
            NSLog("Error reading TTSExample.json")
            return
        }

        let result = Switchboard.createEngine(withJSON: json)
        guard result.success, let id = result.value else {
            NSLog("Failed to create engine")
            return
        }
        engineID = id as String
    }

    func startEngine() {
        guard let engineID else { return }
        let result = Switchboard.callAction(withObject: engineID, actionName: "start", params: nil)
        if !result.success {
            NSLog("Failed to start audio engine")
        }
    }

    func stopEngine() {
        guard let engineID else { return }
        let result = Switchboard.callAction(withObject: engineID, actionName: "stop", params: nil)
        if !result.success {
            NSLog("Failed to stop audio engine")
        }
    }

    func synthesizeText(_ text: String) {
        let result = Switchboard.callAction(withObject: "sherpaTTSNode", actionName: "synthesize", params: ["text": text])
        if !result.success {
            NSLog("Failed to synthesize text")
        }
    }
}
