//
//  ContentView.swift
//  Memorize
//
//  Created by Павел Родионов on 09.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var game: EmojieMemoryGame
    
    init() {
        game = EmojieMemoryGame()
    }

    var body: some View {
        VStack() {
            Text("Memorize!")
                .font(.largeTitle)
                .padding(.vertical)
            
            VStack() {
                Text("Theme: \(game.title)")
                Text("Score: \(game.score)")
                    
            }
            .padding(.vertical)
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 85))
                ]) {
                    ForEach(game.cards) { card in
                        CardView(card: card, color: game.color)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            Spacer()
            Button {
                game.createNewGame()
            } label: {
                Text("Start new game")
            }
        }
        .padding(.horizontal, 3)
    }
    
}

private struct themeSelectorButtonView: View {
    var iconName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.largeTitle)
            Text(title)
        }
    }
}

private struct CardView: View {
    let card: MemoryGame<String>.Card
    let color: Color
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 15)
        
        ZStack {
            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                    .foregroundColor(color)
                
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
        .foregroundColor(color)
    }
}

private struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 12 mini")
                .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
            ContentView()
                .previewDevice("iPhone 12 mini")
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.portrait)
        }
    }
}
