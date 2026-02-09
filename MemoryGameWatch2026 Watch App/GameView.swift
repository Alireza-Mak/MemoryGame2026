//
//  GameView.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-02-05.
//
import SwiftUI
struct GameView: View {
    let bonus: Bool
    let selectedImage: String
    let boardSize = 5
    let board: Board
    @State private var isInitiallyShowingBoard: Bool = true
    
    init(bonus: Bool, selectedImage: String){
        self.bonus = bonus
        self.selectedImage = selectedImage
        board = Board(size: boardSize, treasureSymbol: selectedImage, hasBonus: bonus)
    }
    
    var body: some View {
        VStack{
            ForEach(board.tiles.indices, id: \.self){ row in
                HStack{
                    ForEach(board.tiles[row]){ tile in
                        let isRevealTile = tile.isRevealed
                        let symbolName = isInitiallyShowingBoard || isRevealTile ? tile.contents: "questionmark.circle.dashed"
                        Button(action: {
                            board.revealTile(tile: tile)
                        }){
                            Image(systemName: symbolName)
                                .resizable()
                                .accessibilityLabel("tile")
                                .accessibilityIdentifier("GameImage")
                                .accessibilityValue(symbolName)
                        }
                        .disabled(isInitiallyShowingBoard)
                        .accessibilityIdentifier("GameButton")
                        .accessibilityValue(symbolName)
                        .buttonStyle(.plain)
                        .foregroundStyle(.white)
                    }
                }
            }
            Text("Picks: \(board.treasureCount) Left: \(board.unrevealedTreasureCount())")
                .font(.system(size: 16, weight: .light, design: .serif))
                    .italic()
        }  .padding()
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                    isInitiallyShowingBoard = false
                }
            }
    }
}


#Preview {
    GameView(bonus:true, selectedImage: "sun.max")
}
