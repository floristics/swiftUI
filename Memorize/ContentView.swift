//
//  ContentView.swift
//  Memorize
//
//  Created by Павел Родионов on 09.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            
            Text("Hello, world!")
                .foregroundColor(.orange)
        }
        .padding(.horizontal)
        .foregroundColor(.red)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}
