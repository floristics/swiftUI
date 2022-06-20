//
//  ContentView.swift
//  Memorize
//
//  Created by Павел Родионов on 09.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    struct Theme {
        let id = UUID()
        var title: String
        var iconName: String
        var cardCount: Int
        var emojis: Array<String>
    }
    
    let themes: Array<Theme> = [
        Theme(
            title: "Smiles",
            iconName: "face.smiling",
            cardCount: 6,
            emojis: ["😀", "😂", "😝", "🧐","😇", "🙃", "😚", "🤓","😫", "🙀", "👨‍🍳", "👩‍🌾"]
        ),
        Theme(
            title: "Cars",
            iconName: "car",
            cardCount: 8,
            emojis: ["🚗","🚕","🚙","🚌","🚎","🏎","🚜","🚓","🚑","🚒","🦼","🛻","🚚","🚛"]
        ),
        Theme(
            title: "Flags",
            iconName: "flag",
            cardCount: 12,
            emojis: ["🇦🇹","🇦🇿","🇦🇱","🇧🇧","🇧🇷","🇧🇼","🇧🇴","🇻🇪","🏴󠁧󠁢󠁷󠁬󠁳󠁿","🇻🇬","🇹🇱","🇻🇳","🇮🇱","🇺🇸","🇸🇴"]
        ),
    ]
    
    @State var selectedTheme: Theme
    
    init() {
        let randomTheme = themes.shuffled()[0]
        _selectedTheme = State(initialValue: Theme(
            title: randomTheme.title,
            iconName: randomTheme.iconName,
            cardCount: randomTheme.cardCount,
            emojis: randomTheme.emojis.shuffled()
        ))
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .padding(.vertical)
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 85))
                ]) {
                    let iconSet = selectedTheme.emojis[0..<selectedTheme.cardCount]
                    ForEach(iconSet, id: \.self) { emoji in
                        CardView(emoji: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                    .foregroundColor(.red)
                }
            }
            
            Spacer()
            HStack(spacing: 50) {
                ForEach(themes, id: \.id) { theme in
                    Button{
                        // todo: как сбросить вьюшку, залипают открытые картинки?
                        // нужно ли сбрасывать только передачей нового массива иконок
                        // созданием нового объекта не помогло((
                        self.selectedTheme = Theme(
                            title: theme.title,
                            iconName: theme.iconName,
                            cardCount: theme.cardCount,
                            emojis: theme.emojis.shuffled()
                        )
                    } label: {
                        themeSelectorButtonView(
                            iconName: theme.iconName,
                            title: theme.title)
                    }
                }
            }

        }
        .padding(.horizontal, 3)
    }
    
}

struct themeSelectorButtonView: View {
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

struct CardView: View {
    
    var emoji: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 15)
        
        ZStack {
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                    .foregroundColor(.red)
                
                Text(emoji)
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }

    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 mini")
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
        
        
        ContentView()
            .previewDevice("iPhone 12 mini")
            .preferredColorScheme(.light)
    }
}
