//
//  ContentView.swift
//  Stanford193p
//
//  Created by Adolfo Calderon on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentTheme: CardTheme = .cat
//    @State var cardCount: Int = 4
    
    enum CardTheme {
        case sport, cat, christmas
    }
    
    var currentEmojis: [String] {
        switch currentTheme {
        case .sport:
            return sportEmojis.shuffled()
        case .cat:
            return catEmojis.shuffled()
        case .christmas:
            return christmasEmojis.shuffled()
        }
    }

    let sportEmojis: [String] = ["🚴", "🏃", "🏋️", "🏌️", "🚴", "🏃", "🏋️", "🏌️"]
    let catEmojis: [String] = ["😹", "😻", "🙀", "😿", "😹", "😻", "🙀", "😿"]
    let christmasEmojis: [String] = ["🎄", "🌲", "🎅", "🤶", "🎄", "🌲", "🎅", "🤶"]
    
    var body: some View {
        VStack{
            ScrollView {
                title
                cards
                themes
            }
        }
        .padding()
    }
    
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }
    
    var cards: some View {
        let shuffledCards = currentEmojis.shuffled()
        
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 145))]) {
            ForEach(0..<catEmojis.count, id : \.self) { index in
                CardView(content: shuffledCards[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
    
    var themes: some View {
        VStack(spacing: 5) {
            sportTheme
            catTheme
            christmasTheme
        }
    }
    
    func changeTheme(to theme: CardTheme, icon: String) -> some View {
        Button(action: {currentTheme = theme}) {
            Image(systemName: icon)
        }
    }
    
    var sportTheme: some View {
        VStack {
            Text("Sport Theme")
            changeTheme(to: .sport, icon: "figure.run")
        }
        .font(.title2)
    }
    
    var catTheme: some View {
        VStack {
            Text("Cat Theme")
            changeTheme(to: .cat, icon: "cat.fill")
        }
        .font(.title2)
    }
    
    var christmasTheme: some View {
        VStack {
            Text("Christmas Theme")
            changeTheme(to: .christmas, icon: "snowflake.circle.fill")
        }
        .font(.title2)
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
            .opacity(isFaceUp ? 0 : 1)
            base.fill().opacity(isFaceUp ? 1 : 0)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
