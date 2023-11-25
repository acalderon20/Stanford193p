//
//  MemorizeGame.swift
//  Stanford193p
//
//  Created by Adolfo Calderon on 11/9/23.
//

import Foundation

struct MemoryGame<CardContent> { // can add generics to scope -> <CardContent> is a don't care type
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))

        }
    }
    
    func choose(_ card: Card){
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card { // Could put the generic here, but then you have to specify what "it is" in other scopes
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
    }
}
