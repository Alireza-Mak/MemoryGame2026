//
//  ContentView.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-08.
//

import SwiftUI

struct ContentView: View {
    private static let images: [String] = ["sun.max", "cloud.sun", "cloud.rain"]
    @AppStorage("index") private var index: Int = 0
    @AppStorage("step") private var step: Int = 7
    @AppStorage("bonus") private var bonus: Bool = true
    @State private var showingSettings: Bool = false
    

    var body: some View {
        NavigationStack {
            Group {
                if showingSettings {
                    SettingsView(bonus: $bonus, index: $index, step: $step, images: Self.images)
                } else {
                    GameView(
                        name: Self.images.indices.contains(index) ? Self.images[index] : Self.images.first ?? "questionmark",
                        boardSize: step,
                        bonus: bonus
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSettings.toggle()
                    } label: {
                        Image(systemName: showingSettings ? "house" : "gear")
                            .font(.title2)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
