//
//  GameView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-14.
//
import SwiftUI

struct GameView : View{
    let name: String
    
    var body:some View{
        Image(systemName: name)
            .resizable()
            .frame(width: 100, height: 100)
            .accessibilityLabel(name)
    }
}
