//
//  CardView.swift
//  Zbam
//
//  Created by Yagiz Gunes Teker on 17.01.26.
//

import SwiftUI
import SwiftData

struct CardEditView: View {
    let card: Card
    
    @State private var front: String
    @State private var back: String
    
    @State private var isEditing = false
    @Environment(\.dismiss) private var dismiss
    
    init(card: Card) {
        self.card = card
        self.back = card.back
        self.front = card.front
    }
    
    var body: some View {
        Form {
            HStack {
                TextField("Front", text: $front)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                if !front.isEmpty {
                    Button {
                        front = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Clear front")
                }
            }
            HStack {
                TextField("Back", text: $back)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                if !back.isEmpty {
                    Button {
                        back = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Clear back")
                }
            }
        }
        .navigationTitle("Card")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveCard()
                    dismiss()
                }
            }
        }
    }
    private func saveCard() {
        card.front = front
        card.back = back
    }
}

#Preview(Card.sampleData.first?.front ?? "Edit Card", traits: .cardSampleData) {
    if let first = Card.sampleData.first {
        NavigationStack {
            CardEditView(card: first)
        }
    } else {
        NavigationStack {
            CardEditView(card: Card(front: "Front", back: "Back"))
        }
    }
}
