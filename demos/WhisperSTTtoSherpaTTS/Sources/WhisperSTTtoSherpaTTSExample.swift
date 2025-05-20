//
//  WhisperSTTtoSherpaTTSExample.swift
//  SwitchboardiOSDemo
//
//  Created by Iván Nádor on 2025. 04. 16..
//

import SwiftUI

struct WhisperSTTtoSherpaTTSExample: View {
    @State private(set) var model = ViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Press Start and talk into the microphone to synthesize your speech.")
                .font(.callout)

            Button(action: {
                if model.isRunning {
                    model.isRunning = false
                    model.engine.stopEngine()
                } else {
                    model.isRunning = true
                    model.engine.startEngine()
                }
            }) {
                if model.isRunning {
                    Text("Stop")
                } else {
                    Text("Start")
                }
            }
            .padding()
        }
        .padding()
        .task {
            model.engine.createEngine()
        }
        .onDisappear {
            model.engine.stopEngine()
        }
    }
}

extension WhisperSTTtoSherpaTTSExample {
    @Observable
    class ViewModel: NSObject {
        let engine = STTtoTTSExample()

        var isRunning: Bool = false
    }
}
