//
//  ContentView.swift
//  StandfordSwiftUI
//
//  Created by Guilherme Prata Costa on 14/02/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","💀","🎃","🚨", "🎶", "👀", "👻","💀","🎃","🚨", "🎶", "👀"]
    @State var cardCount = 3
    
    var body: some View {
        VStack {
            cards
            cardCountAdjusters
            
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 120))
        ]){
            
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index], isFaceUp: true)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover : some View {
        cardCountAdjuster(by: -1, symbol: "minus.circle.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "plus.circle.fill")
    }
    
    
}


struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

