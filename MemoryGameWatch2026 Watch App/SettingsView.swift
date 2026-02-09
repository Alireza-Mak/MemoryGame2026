//
//  SettingsView.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-02-05.
//
import SwiftUI

struct SettingsView: View {
    @Binding var bonus: Bool
    @Binding var selectedImageIndex: Int
    let images: [String]
    var body: some View {
        VStack() {
            ImagePickerView(selectedImageIndex: $selectedImageIndex, images: images)
            Toggle("Bonus", isOn: $bonus)
        }
    }
}
#Preview {
    @Previewable @State var bonus = true
    @Previewable @State var selectedImageIndex = 0
    SettingsView(bonus: $bonus, selectedImageIndex: $selectedImageIndex, images: ["sun.max", "cloud.sun", "cloud.rain"])
}
