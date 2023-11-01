//
//  ContentView.swift
//  Stanford193p
//
//  Created by Adolfo Calderon on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentTheme: CardTheme = .halloween
//    @State var cardCount: Int = 4
    
    enum CardTheme {
        case monkey, halloween, christmas
    }
    
    var currentEmojis: [String] {
        switch currentTheme {
        case .monkey:
            return monkeyEmojis.shuffled()
        case .halloween:
            return halloweenEmojis.shuffled()
        case .christmas:
            return christmasEmojis.shuffled()
        }
    }

    let monkeyEmojis: [String] = ["🙈", "🙉", "🙊", "🐵", "🙈", "🙉", "🙊", "🐵"]
    let halloweenEmojis: [String] = ["🎃", "👻", "🪦", "💀", "🎃", "👻", "🪦", "💀"]
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
        Text("Memorize")
            .font(.largeTitle)
    }
    
    var cards: some View {
        let shuffledCards = currentEmojis.shuffled()
        
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 145))]) {
            ForEach(0..<monkeyEmojis.count, id : \.self) { index in
                CardView(content: shuffledCards[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
    
    var themes: some View {
        VStack {
            monkeyButton
            halloweenButton
            christmasButton
        }
    }
    
    func changeTheme(to theme: CardTheme, buttonName: String) -> some View {
        Button(action: {currentTheme = theme}) {
            Text(buttonName)
        }
    }
    
    var monkeyButton: some View {
        changeTheme(to: .monkey, buttonName: "Monkey")
    }
    
    var halloweenButton: some View {
        changeTheme(to: .halloween, buttonName: "Halloween")
    }
    
    var christmasButton: some View {
        changeTheme(to: .christmas, buttonName: "Christmas")
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
