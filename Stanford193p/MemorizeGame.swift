//
//  MemorizeGame.swift
//  Stanford193p
//
//  Created by Adolfo Calderon on 11/9/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable { // can add generics to scope | <CardContent> is a don't care type
    private(set) var cards: Array<Card>
    
    private (set) var score: Int = 0
    private(set) var seenBefore = false
    
    
    
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        /// Add numberOfPairsOfCards x 2
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter{ index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
        }
    }
    
    
    
    // MARK: - Card Functions
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    /// At this point two cards have been flipped up, if not one
                    
                    /// Card Matched!
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    }
                    /// Both seenBefore
                    else if cards[chosenIndex].seenBefore && cards[potentialMatchIndex].seenBefore {
                        score -= 2
                    }
                    /// Card1 seenBefore
                    else if cards[chosenIndex].seenBefore && !cards[potentialMatchIndex].seenBefore {
                        score -= 1
                        cards[potentialMatchIndex].seenBefore = true
                    }
                    /// Card2 seenBefore
                    else if !cards[chosenIndex].seenBefore && cards[potentialMatchIndex].seenBefore {
                        score -= 1
                        cards[chosenIndex].seenBefore = true
                    }
                    /// Neither seenBefore
                    else if !cards[chosenIndex].seenBefore && !cards[potentialMatchIndex].seenBefore {
                        cards[chosenIndex].seenBefore = true
                        cards[potentialMatchIndex].seenBefore = true
                    }
                }
                else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    
    // MARK: - Card Struct
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var seenBefore = false
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "Matched" : "")"
        }
    }
}

// MARK: - Extensions

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
