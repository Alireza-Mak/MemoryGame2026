//
//  ContentView.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-08.
//

import SwiftUI

/// The app's root view that toggles between the game and settings screens.
///
/// ContentView persists user selections (symbol index, board size, bonus mode)
/// using `@AppStorage` and presents either `GameView` or `SettingsView` within
/// a navigation stack with a single toolbar button to switch modes.
struct ContentView: View {
    /// Available SF Symbol names for selection.
    private static let images: [String] = ["sun.max", "cloud.sun", "cloud.rain", "cloud"]
    /// Persisted index of the selected symbol.
    @AppStorage("index") private var index: Int = 0
    /// Persisted board size (number of rows/columns).
    @AppStorage("step") private var step: Int = 7
    /// Persisted bonus mode toggle.
    @AppStorage("bonus") private var bonus: Bool = true
    /// Controls whether settings are shown instead of the game.
    @State private var showingSettings: Bool = false
    
    
    /// Renders the main navigation and switches between SettingsView and GameView.
    var body: some View {
//        NavigationStack {
//            Group {
//                if showingSettings {
//                    SettingsView(bonus: $bonus, index: $index, step: $step, images: Self.images)
//                } else {
//                    GameView(
//                        name: Self.images.indices.contains(index) ? Self.images[index] : Self.images.first ?? "questionmark",
//                        boardSize: step,
//                        bonus: bonus
//                    )
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        showingSettings.toggle()
//                    } label: {
//                        Image(systemName: showingSettings ? "house" : "gear")
//                            .font(.title2)
//                    }
//                }
//            }
//        }
        GameView(
            name: Self.images.indices.contains(index) ? Self.images[index] : Self.images.first ?? "questionmark",
            boardSize: step,
            bonus: bonus
        )
    }
}

// Preview showcasing the root ContentView in its default state.
#Preview {
    ContentView()
}

