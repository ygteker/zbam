//
//  CardView.swift
//  Zbam
//
//  Created by Yagiz Gunes Teker on 17.01.26.
//

import SwiftUI
import SwiftData

struct CardView: View {
    let card: Card
    @State private var answer: String
    @State private var isPresentingEditView: Bool = false
    
    init(card: Card) {
        self.card = card
        self._answer = State(initialValue: card.front)
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                Text(answer)
                Button(action: flip) {
                    Text("Show answer")
                }
                .toolbar {
                    Button("Edit") {
                        isPresentingEditView = true
                    }
                }
                .sheet(isPresented: $isPresentingEditView) {
                    NavigationStack {
                        CardEditView(card: card)
                            .navigationTitle("Card")
                    }
                }
            }
        }
    }
    
    func flip() {
        if answer == card.back {
            answer = card.front
        } else {
            answer = card.back
        }
    }
}

#Preview(Card.sampleData.first?.front ?? "Card Preview", traits: .cardSampleData) {
    // Use the first sample card
    if let first = Card.sampleData.first {
        CardView(card: first)
    } else {
        // Fallback if sample data is empty
        CardView(card: Card(front: "Front", back: "Back"))
    }
}
