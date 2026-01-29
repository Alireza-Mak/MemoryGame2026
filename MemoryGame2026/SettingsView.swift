//
//  SettingsView.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-13.
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
                .accessibilityIdentifier("SettingsRowsColsText")
                .accessibilityValue(String(step))
            }
            .accessibilityIdentifier("SettingsStepper")
            
            Toggle("Bonus mode", isOn: $bonus)
                .accessibilityIdentifier("SettingsBonusToggle")
        }
        
        .navigationTitle("Settings")
        .padding(25)
    }
}
#Preview("SettingsView") {
    @Previewable @State var bonus = true
    @Previewable @State var index = 0
    @Previewable @State var step = 7
    return SettingsView(bonus: $bonus, index: $index, step: $step, images: ["sun.max", "cloud.sun", "cloud.rain"])
}

