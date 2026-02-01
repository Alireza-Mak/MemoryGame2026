//
//  Board.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-26.
//

import SwiftUI

/// A square grid board for a simple treasure-hunt style memory game.
///
/// Manages a 2D array of `Tile` objects, places a configurable number of
/// treasure tiles and an optional single bonus tile, and tracks interaction
/// state such as taps and revealed treasures. Exposes helpers to populate,
/// reveal, and query board state.
@Observable
class Board {
    /// SF Symbol used for empty (unrevealed) tiles.
    private static let emptySymbol = "circle"
    /// SF Symbol used for the bonus tile.
    private static let bonusSymbol = "bitcoinsign.circle"
    /// Board dimension (rows and columns), clamped during init.
    let size: Int
    /// Minimum allowed board size.
    private static let minSize = 5
    /// Maximum allowed board size.
    private static let maxSize = 10
    /// SF Symbol used for treasure tiles.
    private let treasureSymbol: String
    /// Whether a single bonus tile should be placed.
    private let hasBonus: Bool
    /// Number of consecutive taps since the last bonus tile was revealed.
    private(set) var tapCount: Int = 0
    /// Number of treasure tiles revealed so far.
    private(set) var treasureCount: Int = 0
    /// The 2D grid of tiles (rows x columns).
    private(set) var tiles: [[Tile]] = []
    
    /// Creates a new board with the given configuration.
    /// - Parameters:
    ///   - size: Desired board dimension; clamped to `minSize...maxSize`.
    ///   - treasureSymbol: SF Symbol name for treasure tiles.
    ///   - hasBonus: If true, places exactly one bonus tile at random.
    init(size: Int, treasureSymbol: String, hasBonus: Bool) {
        self.size = Self.clamp(value: size, minVal: Self.minSize, maxVal: Self.maxSize)
        self.treasureSymbol = treasureSymbol
        self.hasBonus = hasBonus
        fillBoard()
    }
    
    /// Builds a fresh grid of empty tiles and places bonus/treasure tiles.
    ///
    /// Clears any existing tiles, fills the grid with empty tiles, then (optionally)
    /// places one bonus tile and distributes treasure tiles across empty cells.
    func fillBoard() {
        tiles.removeAll(keepingCapacity: true)
        
        for _ in 1...self.size {
            var row  = [Tile]()
            for _ in 1...self.size {
                row.append(Tile(contents: Self.emptySymbol))
            }
            tiles.append(row)
        }
        
        if hasBonus {
            placeBonusTile()
        }
        placeTreasureTiles()
    }
    
    /// Randomly selects a single cell and marks it as the bonus tile.
    func placeBonusTile(){
        let (randomRow, randomCol) = randomIndex()
        tiles[randomRow][randomCol].contents = Self.bonusSymbol
    }
    
    /// Randomly places treasure tiles on empty cells until the target count is reached.
    ///
    /// Ensures treasures do not overwrite previously placed tiles (bonus or treasure).
    func placeTreasureTiles() {
        var numberOfTreasure = computeTreasureCount()
        while numberOfTreasure > 0 {
            let (randomRow, randomCol) = randomIndex()
            if tiles[randomRow][randomCol].contents == Self.emptySymbol {
                tiles[randomRow][randomCol].contents = self.treasureSymbol
                numberOfTreasure -= 1
            }
        }
    }

    /// Computes how many treasure tiles to place based on board area (25%).
    /// - Returns: The rounded number of treasure tiles to place.
    func computeTreasureCount() -> Int {
        let totalTiles = self.size * self.size
        return Int((Double(totalTiles) * 0.25).rounded())
    }
    
    /// Reveals a tile and updates counters for treasures and taps.
    /// - Parameter tile: The tile to reveal; ignored if already revealed.
    func revealTile(tile: Tile) {
        if !tile.isRevealed {
            tile.reveal()
            treasureCount =  isTreasure(tile: tile) ? treasureCount + 1 : treasureCount
            tapCount = isBonus(tile: tile) ? 0 : tapCount + 1
        }
    }
    
    /// Checks whether the given tile is a treasure.
    /// - Parameter tile: Tile to inspect.
    /// - Returns: `true` if the tile's contents match `treasureSymbol`.
    func isTreasure(tile: Tile) -> Bool {
        return tile.contents == self.treasureSymbol
    }
    
    /// Checks whether the given tile is the bonus tile.
    /// - Parameter tile: Tile to inspect.
    /// - Returns: `true` if the tile's contents match the bonus symbol.
    func isBonus(tile: Tile) -> Bool {
        return tile.contents == Self.bonusSymbol
    }
    
    /// The number of treasure tiles that have not yet been revealed.
    /// - Returns: Total treasure count minus the number already revealed.
    func unrevealedTreasureCount() -> Int {
        return computeTreasureCount() - treasureCount
    }
    
    /// Clamps an integer value to a closed range defined by `minVal...maxVal`.
    /// - Parameters:
    ///   - value: The value to clamp.
    ///   - minVal: Inclusive lower bound.
    ///   - maxVal: Inclusive upper bound.
    /// - Returns: The clamped value.
    private static func clamp(value: Int, minVal:Int, maxVal:Int) -> Int {
        return min(max(value, minVal), maxVal)
    }
    
    /// Generates a random valid (row, column) index within the board bounds.
    /// - Returns: A tuple containing random row and column indices.
    private func randomIndex() -> (row: Int, col: Int) {
        (Int.random(in: 0..<self.size), Int.random(in: 0..<self.size))
    }
}

