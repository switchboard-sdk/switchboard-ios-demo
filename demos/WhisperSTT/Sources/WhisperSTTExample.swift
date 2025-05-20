//
//  WhisperSTTExample.swift
//  SwitchboardiOSDemo
//
//  Created by Iván Nádor on 2025. 04. 16..
//

import SwiftUI

struct WhisperSTTExample: View {
    @State private(set) var model = ViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Press Start and talk into the microphone to transcribe.")
                .font(.callout)

            Text(model.transcribedText)
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                .multilineTextAlignment(.leading)

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

extension WhisperSTTExample {
    @Observable
    class ViewModel: NSObject, STTExampleDelegate {
        let engine = STTExample()

        var isRunning: Bool = false
        var transcribedText: String = ""

        override init() {
            super.init()
            self.engine.delegate = self
        }

        func transcribedText(_ text: String) {
            transcribedText += text + "\n"
        }
    }
}
