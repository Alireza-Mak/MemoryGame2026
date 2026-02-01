//
//  GameView.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-14.
//
import SwiftUI
import Combine

/// A SwiftUI view that renders an interactive memory board game.
///
/// GameView is responsible for:
/// - Constructing a `Board` model with the provided configuration
/// - Rendering the grid of tiles
/// - Temporarily showing all tiles as a brief preview before gameplay
/// - Forwarding user taps to the board to reveal tiles
///
/// The view orchestrates UI state; game rules and counters are managed by `Board`.
struct GameView: View {
    /// The SF Symbols name used as the treasure marker (e.g., "sun.max").
    private let name: String
    /// The square dimension of the board (e.g., 5 creates a 5×5 grid).
    private let boardSize: Int
    /// Indicates whether bonus logic is enabled for the game session.
    private let bonus: Bool
    /// The game board model responsible for tile state and counters.
    private let board: Board
    /// Controls whether the board is currently in a preview state.
    /// When true, all tiles are shown and interactions are disabled until the preview ends.
    @State private var isInitiallyShowingBoard: Bool = true

    /// Creates a new game view with the given configuration.
    /// - Parameters:
    ///   - name: The SF Symbols name used for treasure tiles.
    ///   - boardSize: The square dimension of the board (e.g., 5 for a 5×5 grid).
    ///   - bonus: Enables bonus behavior in the underlying `Board`.
    init(name: String, boardSize: Int, bonus: Bool) {
        self.name = name
        self.boardSize = boardSize
        self.bonus = bonus
        self.board = Board(size: boardSize, treasureSymbol: name, hasBonus: bonus)
    }
   
    
    /// The primary view content that renders the board and counters, and handles user interactions.
    /// Displays a brief preview of all tiles on appear before enabling gameplay.
    var body: some View {
        VStack{
            ForEach(board.tiles.indices, id: \.self){ row in
                HStack{
                    ForEach(board.tiles[row]){ tile in
                        Button(action: {
                            board.revealTile(tile: tile)
                        }){
                            let isRevealTile = tile.isRevealed
                            let symbolName = isInitiallyShowingBoard || isRevealTile ? tile.contents: "questionmark.circle.dashed"

                            Image(systemName: symbolName)
                                .resizable()
                                .aspectRatio(contentMode:.fit)
                                .accessibilityLabel("tile")
                                .accessibilityIdentifier("GameImage")
                                .accessibilityValue(name)
                        }
                        .disabled(isInitiallyShowingBoard)
                    }
                }
                .padding()
            }

            Spacer()

            Text("Tap counter: \(board.tapCount) ")
            
            Text("Treasures found: \(board.treasureCount)")
            // Shows remaining unrevealed treasures
            Text("Unreveal treasures: \(board.unrevealedTreasureCount())")
        }
        .padding()
        .onAppear {
            // Start a one-time preview window: reveal all tiles briefly, then hide them and enable play.
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
                isInitiallyShowingBoard.toggle()
            }
        }
    }
}
// Preview showcasing a 5×5 board with bonus enabled and "sun.max" as the treasure symbol.
#Preview("GameView") {
    GameView(name: "sun.max", boardSize: 5, bonus: true)
}

