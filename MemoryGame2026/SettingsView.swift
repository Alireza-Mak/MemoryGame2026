//
//  SettingsView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-13.
//
import SwiftUI

struct SettingsView: View {

    @Binding var bonus: Bool
    @Binding var index: Int
    @Binding var step: Int
    let images: [String]

    var body: some View {
        VStack(spacing: 20) {
            ImagePickerView(index: $index, images: images)
            Stepper(value: $step, in: 5...10) {
                Text("\(step) Rows/Cols")
                    .accessibilityLabel("Grid size")
                    .accessibilityValue("\(step) by \(step)")
            }
            Toggle("Bonus mode", isOn: $bonus)
        }
        .navigationTitle("Settings")
        .padding(20)
    }
}
#Preview("SettingsView") {
    @State var bonus = true
    @State var index = 0
    @State var step = 7
    return SettingsView(bonus: $bonus, index: $index, step: $step, images: ["sun.max", "cloud.sun", "cloud.rain"]) 
        .padding()
}

