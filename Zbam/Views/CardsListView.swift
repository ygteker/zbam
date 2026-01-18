//
//  CardsView.swift
//  Zbam
//
//  Created by Yagiz Gunes Teker on 17.01.26.
//

import SwiftUI
import SwiftData

struct CardsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Card.front) private var cards: [Card]
    @State private var isAddingCard: Bool = false
    
    var body: some View {
        NavigationStack {
            List(cards, id: \.id) { card in
                NavigationLink(destination: CardView(card: card)) {
                    Text(card.front)
                }
            }
            .navigationTitle("Cards")
            .toolbar {
                Button(action: {
                    isAddingCard = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
            .sheet(isPresented: $isAddingCard) {
                NavigationStack {
                    // Use the creation view that has a no-arg initializer
                    CreateCardView()
                        .navigationTitle("Create New Card")
                }
            }
        }
    }
}

#Preview(traits: .cardSampleData) {
    CardsListView()
}
