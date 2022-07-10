//
//  MemoryGame.swift
//  Memorize
//
//  Created by Павел Родионов on 24.06.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    let theme: Theme
    private(set) var score: Int = 0
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    init(theme: Theme, createCardContent: (Int) -> CardContent) {
        self.theme = theme
        
        var cards = Array<Card>()
        for pairIndex in 0..<theme.calculatePairsCount() {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
        self.cards = cards.shuffled()
    }
    
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[choosenIndex].isFaceUp,
           !cards[choosenIndex].isMatched
        {
            print(choosenIndex)
            // action for cards matching
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[choosenIndex].content == cards[potentialMatchIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    score+=2
                } else if cards[choosenIndex].isViewed {
                    score-=1
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else { // action for cards mismatching
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = choosenIndex
            }
            cards[choosenIndex].isFaceUp.toggle()
            cards[choosenIndex].isViewed = true
        }
    }
    
    enum Color {
        case orange
        case blue
        case red
        case green
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isViewed: Bool = false
        let content: CardContent
        let id = UUID()
    }
    
    struct Theme: Identifiable {
        let id = UUID()
        let title: String
        let contentSet: Array<CardContent>
        let pairsCount: Int
        let color: Color
        
        func calculatePairsCount() -> Int {
            if pairsCount > contentSet.count {
                return contentSet.count
            }
            
            return pairsCount
        }
    }
}
