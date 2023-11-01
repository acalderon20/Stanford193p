//
//  ContentView.swift
//  Stanford193p
//
//  Created by Adolfo Calderon on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    let emojis : [String] = ["😭", "😭", "😈", "😼", "😳", "😳", "😳", "😳", "😳", "😳", "😳", "😳"]
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack{
            ScrollView {
                cards
                Spacer()
                cardCountAdjusters
            }
        }
        .padding()
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
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 145))]) {
            ForEach(0..<cardCount, id : \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
    
    func cardCountAdjusters(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
        
    }
    
    var cardRemover: some View {
        cardCountAdjusters(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    var cardAdder: some View {
        cardCountAdjusters(by: +1, symbol: "rectangle.stack.fill.badge.plus")

    }
    
    
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle) // emoji shown
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1) // the "back" of the cards
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
