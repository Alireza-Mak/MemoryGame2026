//
//  GameView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-14.
//
import SwiftUI

struct GameView: View {
    let name: String
    
    var body: some View {
        Image(systemName: name)
            .resizable()
            .symbolRenderingMode(.hierarchical)
            .accessibilityLabel(Text(name))
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 25)
    }
}
#Preview("GameView") {
    GameView(name: "sun.max")
        .padding()
}

