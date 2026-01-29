//
//  GameView.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-14.
//
import SwiftUI
internal import Combine

struct GameView: View {
    private let name: String
    private let boardSize: Int
    private let bouns: Bool
    private let board: Board
    @State private var isInitialyShowBoard: Bool = true


    init(name: String, boardSize: Int, bonus: Bool) {
        self.name = name
        self.boardSize = boardSize
        self.bouns = bonus
        self.board = Board(n: boardSize, treasure: name, hasBonus: bonus)
    }
   
    var body: some View {

        VStack{
            ForEach(board.tiles, id: \.first!.id){ row in
                HStack{
                    ForEach(row){ tile in
                        
                        Button(action: {
                            board.revealTile(tile: tile)
                        }){
                            let isRevealTile = tile.isRevealed
                            let content = isInitialyShowBoard || isRevealTile ? tile.contents: "questionmark.circle.dashed"

                            Image(systemName: content)
                                .resizable()
                                .aspectRatio(contentMode:.fit)
                                .accessibilityLabel(Text(name))
                                .accessibilityIdentifier("GameImage")
                                .accessibilityValue(name)
                        }
                        .disabled(isInitialyShowBoard)
                    }
                }
                .padding()
            }
            Text("Tap counter: \(board.tapCount) ")
            Text("Treasure counter: \(board.treasureCount)")
            Text("Unreveal treasures: \(board.getUnrevealedTreasures())")
        }
        .padding()
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
                isInitialyShowBoard.toggle()
            }
        }
    }
}
#Preview("GameView") {
    GameView(name: "sun.max", boardSize: 10, bonus: true)
}
