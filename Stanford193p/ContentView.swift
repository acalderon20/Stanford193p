//
//  ContentView.swift
//  Stanford193p
//
//  Created by Adolfo Calderon on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    let emojis : [String] = ["😂", "😭", "😈", "😼", "😳"]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id : \.self) { index in
                CardView(content: emojis[index], isFaceUp: true)
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack(content: {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            else {
                RoundedRectangle(cornerRadius: 12)
            }
        })
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
