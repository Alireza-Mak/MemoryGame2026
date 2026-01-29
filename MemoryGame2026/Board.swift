//
//  Tile.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-26.
//

import SwiftUI

@Observable
class Board {
    private let empty: String = "circle"
    private let bouns: String = "bitcoinsign.circle"
    var n : Int
    var treasure : String
    var hasBouns : Bool
    var tapCount : Int = 0
    var treasureCount : Int = 0
    
    
    var tiles = [[Tile]]()
    
    init (n: Int, treasure: String, hasBonus: Bool){
        self.n = (n < 5 || n > 10) ? (n > 10 ? 10 : 5) : n
        self.treasure = treasure
        self.hasBouns = hasBonus
        
        fillBoard()
    }
    
    func fillBoard() {
        
        for _ in 1...self.n {
            var row  = [Tile]()
            for _ in 1...self.n {
                row.append(Tile(contents: self.empty))
            }
            tiles.append(row)
        }
        
        self.hasBouns ? setBounsTile() : nil
        setTreasureTiles()
    }
    
    func setBounsTile(){
        let randomRow = Int.random(in: 0..<self.n)
        let randomCol = Int.random(in: 0..<self.n)
        tiles[randomRow][randomCol].contents = self.bouns
    }
    
    func setTreasureTiles() {
        var numberOfTreasure = setNumOfTreasure()
        while numberOfTreasure > 0 {
            let randomRow = Int.random(in: 0..<self.n)
            let randomCol = Int.random(in: 0..<self.n)
            if tiles[randomRow][randomCol].contents == self.empty {
                tiles[randomRow][randomCol].contents = self.treasure
                numberOfTreasure -= 1
            }
        }
    }
    
    func randomNum(min: Int, max: Int) -> Int {
        return Int.random(in: min..<max)
    }
    
    func setNumOfTreasure() -> Int {
        let totalTiles = self.n * self.n
        let numberOfTreasure = (Double(totalTiles) * 0.25).rounded()
        return Int(numberOfTreasure)
    }
    
    func revealTile(tile: Tile) {
        if !tile.isRevealed {
            tile.reveal()
            treasureCount =  isTreasure(tile: tile) ? treasureCount + 1 : treasureCount
            tapCount = isBonus(tile: tile) ? 0 : tapCount + 1
        }
    }
    
    func isTreasure(tile: Tile) -> Bool {
        return tile.contents == self.treasure
    }
    
    func isBonus(tile: Tile) -> Bool {
        return tile.contents == self.bouns
    }
    
    func getUnrevealedTreasures() -> Int {
        return setNumOfTreasure() - treasureCount
    }
}
