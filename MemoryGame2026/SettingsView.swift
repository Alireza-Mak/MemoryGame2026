//
//  SettingsView.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-13.
//
import SwiftUI

/// A settings screen for configuring the game.
///
/// SettingsView lets the user pick a treasure symbol, adjust the board size,
/// and toggle bonus mode. Values are bound to external state owned by the parent.
struct SettingsView: View {
    /// Binding to the bonus mode toggle.
    @Binding var bonus: Bool
    /// Binding to the selected symbol index used by ImagePickerView.
    @Binding var index: Int
    /// Binding to the square board dimension (rows/columns).
    @Binding var step: Int
    /// Available SF Symbol names to present in the picker.
    let images: [String]

    
    /// Renders controls for symbol selection, board size, and bonus mode.
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
        .padding(25)
    }
}

// Preview showcasing SettingsView with sample bindings and three symbol options.
#Preview("SettingsView") {
    @Previewable @State var bonus = true
    @Previewable @State var index = 0
    @Previewable @State var step = 7
    return SettingsView(bonus: $bonus, index: $index, step: $step, images: ["sun.max", "cloud.sun", "cloud.rain"])
}

