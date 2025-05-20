//
//  SherpaTTSExample.swift
//  SwitchboardiOSDemo
//
//  Created by Iván Nádor on 2025. 04. 15..
//

import SwiftUI

struct SherpaTTSExample: View {
    @State private var inputText: String = ""

    private let engine = TTSExample()

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter text in the text field below to synthesize speech.")
                .font(.callout)

            TextField("Enter text here", text: $inputText, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disableAutocorrection(true)

            Button(action: {
                startAction(with: inputText)
            }) {
                Text("Synthesize")
            }
            .disabled(inputText.isEmpty)
            .padding()
        }
        .padding()
        .task {
            engine.createEngine()
            engine.startEngine()
        }
        .onDisappear {
            engine.stopEngine()
        }
    }

    private func startAction(with text: String) {
        engine.synthesizeText(text)
    }
}
