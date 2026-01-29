//
//  Tile.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-26.
//

import SwiftUI

@Observable
class Tile: Identifiable {
    var contents: String
    var id = UUID()
    var isRevealed: Bool = false
    
    init(contents: String){
        self.contents = contents
    }
    
    func reveal() {
        isRevealed = true
    }
}
