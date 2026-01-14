//
//  ContentView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-08.
//

import SwiftUI

struct ContentView: View {
    @State private var images: [String]  = ["sun.max", "cloud.sun", "cloud.rain"]
    @AppStorage("index") private var index: Int = 0
    @AppStorage("step") private var step: Int = 7
    @AppStorage("bouns") private var bouns: Bool = true

    var body: some View {
        VStack(spacing: 20){
            ImagePickerView(
                index: $index,
                images: $images
            )
            Stepper(value:$step, in:5...10){Text("\(step) Rows/Cols")}
            Toggle("Bouns", isOn: $bouns)
        }
        .padding(30)
    }
}

#Preview {
    ContentView()
}
