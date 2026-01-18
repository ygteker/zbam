//
//  ContentView.swift
//  Zbam
//
//  Created by Yagiz Gunes Teker on 16.01.26.
//

import SwiftUI
import SwiftData

struct CreateCardView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var frontValue: String = ""
    @State private var backValue: String = ""

    var body: some View {
        Form{
            VStack(alignment: .leading, spacing: 20) {
                TextField("Front", text: $frontValue)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                TextField("Back", text: $backValue)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .textInputAutocapitalization(.never)
            }
        }
        .navigationTitle("Create New Card")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    submitValues()
                    dismiss()
                }
            }
        }
    }
    
    func submitValues() {
        let card = Card(front: frontValue, back: backValue)
        modelContext.insert(card)

        frontValue = ""
        backValue = ""
    }
}

#Preview {
    NavigationStack {
        CreateCardView()
            .modelContainer(for: [Card.self], inMemory: true)
    }
}
