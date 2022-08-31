//
//  ContentView.swift
//  Memorize
//
//  Created by Павел Родионов on 09.06.2022.
//

import SwiftUI

struct EmojieMemoryGameView: View {
    @ObservedObject var game: EmojieMemoryGame
    
    // Спросить Витю.
    init(_ game: Optional<EmojieMemoryGame>) {
        self.game = game ?? EmojieMemoryGame()
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
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                cardView(for: card)
                    .animation(Animation.easeIn)
            }
//            .foregroundColor(.red)
//            .padding(.horizontal)
            
            Spacer()
            Button {
                game.createNewGame()
            } label: {
                Text("Start new game")
            }
        }
        .padding(.horizontal, 3)
    }
    
    @ViewBuilder
    private func cardView(for card: MemoryGame<String>.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card, color: game.color)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
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

private struct CardView: View, Animatable {
    let card: MemoryGame<String>.Card
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: 0-90, endAngle: 90-90)
                    .foregroundColor(.red)
                    .padding(5)
                    .opacity(0.5)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false))
                    .font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, color: color)
            .foregroundColor(color)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}

struct EmojieMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojieMemoryGame()
        game.choose(game.cards.first!)
        
        return Group {
             EmojieMemoryGameView(game)
                .previewDevice("iPhone 12 mini")
                .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
        }
    }
}
