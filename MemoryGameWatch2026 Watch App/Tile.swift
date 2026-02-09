//
//  Tile.swift
//  MemoryGameWatch2026App
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-02-09.
//

import SwiftUI

/// A single board cell that displays an SF Symbol and can be revealed.
///
/// `Tile` holds the visual symbol to show, a stable identifier, and a flag
/// indicating whether it has been revealed. It uses `@Observable` so UI can
/// react to state changes.
@Observable
class Tile: Identifiable {
    /// The SF Symbol name shown for this tile.
    var contents: String
    /// Stable unique identifier for the tile.
    let id = UUID()
    /// Whether the tile has been revealed.
    var isRevealed: Bool = false
    
    /// Creates a tile with the given symbol contents.
    /// - Parameter contents: The SF Symbol name to display.
    init(contents: String){
        self.contents = contents
    }
    
    /// Marks the tile as revealed.
    func reveal() {
        isRevealed = true
    }
}
