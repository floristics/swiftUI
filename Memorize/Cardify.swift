//
//  Cardify.swift
//  Memorize
//
//  Created by Павел Родионов on 22.08.2022.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    var color: Color
    
    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
        
        ZStack {
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(color)
                    
               content.transition(.scale)
            } else {
                shape.fill().transition(.identity)
            }
        }
        .foregroundColor(color)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool, color: Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
