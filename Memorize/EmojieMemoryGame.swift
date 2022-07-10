//
//  EmojieMemoryGame.swift
//  Memorize
//
//  Created by Павел Родионов on 24.06.2022.
//

import SwiftUI

class EmojieMemoryGame: ObservableObject {
    
    private static let themes: Array<MemoryGame<String>.Theme> = [
        MemoryGame<String>.Theme(
            title: "Smiles",
            contentSet: ["😀", "😂", "😝", "🧐","😇", "🙃", "😚", "🤓","😫", "🙀", "👨‍🍳", "👩‍🌾"],
            pairsCount: 6,
            color: .red
        ),
        MemoryGame<String>.Theme(
            title: "Cars",
            contentSet: ["🚗","🚕","🚙","🚌","🚎","🏎","🚜","🚓","🚑","🚒","🦼","🛻","🚚","🚛"],
            pairsCount: 56,
            color: .orange
        ),
        MemoryGame<String>.Theme(
            title: "Flags",
            contentSet: ["🇦🇹","🇦🇿","🇦🇱","🇧🇷","🇧🇼","🇧🇴","🇻🇪","🏴󠁧󠁢󠁷󠁬󠁳󠁿","🇻🇬","🇹🇱","🇻🇳","🇮🇱"],
            pairsCount: 12,
            color: .blue
        ),
        MemoryGame<String>.Theme(
            title: "Numbers",
            contentSet: ["1️⃣","2️⃣","3️⃣","4️⃣","5️⃣"],
            pairsCount: 5,
            color: .green
        ),
    ]
    
    init() {
        model = EmojieMemoryGame.createMemoryGame(currentTheme: nil)
    }
    
    @Published private var model: MemoryGame<String>
    
    var title: String {
        return model.theme.title
    }
    
    var color: Color {
        return convertThemeColor(model.theme.color)
    }
    
    var score: Int {
        return model.score
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    private static func getRandomTheme(currentTheme: MemoryGame<String>.Theme?) -> MemoryGame<String>.Theme {
        if let themeToExclude = currentTheme {
            return EmojieMemoryGame.themes
                .filter { $0.id != themeToExclude.id }
                .randomElement()!
        }
        return EmojieMemoryGame.themes.randomElement()!
    }
    
    private static func createMemoryGame(currentTheme: MemoryGame<String>.Theme?) -> MemoryGame<String> {
        let theme = EmojieMemoryGame.getRandomTheme(currentTheme: currentTheme)
        let emojies = theme.contentSet.shuffled()
        
        return MemoryGame<String>(theme: theme) { pairIndex in
            return emojies[pairIndex]
        }
    }
    
    private func convertThemeColor(_ colorName: MemoryGame<String>.Color) -> Color {
        switch(colorName) {
            case .green:
                return .green
            case .orange:
                return .orange
            case .blue:
                return .blue
            case .red:
            fallthrough
            default:
                return .red
        }
    }
    
    func createNewGame() {
        model = EmojieMemoryGame.createMemoryGame(currentTheme: model.theme)
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
