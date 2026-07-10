//
//  STTtoTTSExample.swift
//  SwitchboardiOSDemo
//

import Foundation
import SwitchboardSDK

class STTtoTTSExample {
    private var engineID: String?

    func createEngine() {
        guard let path = Bundle.main.path(forResource: "STTtoTTSExample", ofType: "json"),
              let json = try? String(contentsOfFile: path, encoding: .utf8)
        else {
            NSLog("Error reading STTtoTTSExample.json")
            return
        }

        let result = Switchboard.createEngine(withJSON: json)
        guard result.success, let id = result.value else {
            NSLog("Failed to create engine")
            return
        }
        engineID = id as String

        Switchboard.addEventListener("vadNode", eventName: "speechStarted") { _ in
            NSLog("STT - vadNode start")
        }

        Switchboard.addEventListener("vadNode", eventName: "speechEnded") { _ in
            NSLog("STT - vadNode end")
        }

        Switchboard.addEventListener("sttNode", eventName: "transcribed") { eventData in
            guard let text = eventData["text"] as? String else { return }
            NSLog("STT - transcribed: %@", text)
        }
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
}
