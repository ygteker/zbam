//
//  CardsView.swift
//  Zbam
//
//  Created by Yagiz Gunes Teker on 17.01.26.
//

import SwiftUI
import SwiftData

struct CardsListView: View {
    @Query(sort: \Card.front) private var cards: [Card]
    
    var body: some View {
        NavigationStack {
            List(cards) { card in
                NavigationLink(destination: CardView(card: card)) {
                    Text(card.front)
                }
            }
            .navigationTitle("Cards")
        }
    }
}

#Preview(traits: .cardSampleData) {
    CardsListView()
}
