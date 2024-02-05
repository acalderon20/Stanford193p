//
//  EmojiMemoryGame.swift
//  Stanford193p
//
//  Created by Adolfo Calderon on 11/9/23.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject{
    @Published private var model: MemoryGame<String>
    private var themes: [Theme]
    var currentTheme: Theme

    struct Theme {
        let name: String
        let emojis: [String]
        let numberOfPairsOfCards: Int
        let color: Color
    }
    
    init() {
        themes = [
            Theme(name: "cats", emojis: ["🐱", "😸", "🐈", "😽", "🐾", "😹", "🙀", "😻"], numberOfPairsOfCards: 12, color: .orange),
            Theme(name: "christmas", emojis: ["🎄", "🎁", "❄️", "⛄️", "🎅", "🤶", "🎉", "🔔"], numberOfPairsOfCards: 12, color: .red),
            Theme(name: "halloween", emojis: ["🎃", "👻", "🕷", "🍬", "🕸", "🦇", "🧙‍♂️", "🧛‍♂️"], numberOfPairsOfCards: 12, color: .black),
            Theme(name: "emoji", emojis: ["😀", "😂", "🥰", "😍", "🤪", "😎", "🤓", "😡"], numberOfPairsOfCards: 12, color: .yellow),
            Theme(name: "purple", emojis: ["🟣", "🔮", "🍇", "☂️", "💜", "🦄", "🧞‍♀️", "👾"], numberOfPairsOfCards: 12, color: .purple),
            Theme(name: "green", emojis: ["🟢", "🍏", "🥦", "🐢", "🦚", "🍀", "🧩", "💚"], numberOfPairsOfCards: 12, color: .green)
        ]
        currentTheme = themes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(theme: currentTheme)
    }
    
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        
        return MemoryGame(numberOfPairsOfCards: 12) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return theme.emojis.randomElement()!
            }
        }
    }

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    // MARK: - Intents
    
    func getScore() -> String {
        return String(model.score)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func resetGame() {
        currentTheme = themes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(theme: currentTheme)
        shuffle()
        }
    
    func choose(_ card: MemoryGame<String>.Card) {
        return model.choose(card)
    }
}
