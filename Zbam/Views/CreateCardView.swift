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

    @State private var frontValue: String = ""
    @State private var backValue: String = ""

    var body: some View {
        VStack {
            Text("Front")
            TextField(
                "Front",
                text: $frontValue
            )
            .textInputAutocapitalization(.never)
            .border(.secondary)
            Text("Back")
            TextField(
                "Back",
                text: $backValue
            )
            .textInputAutocapitalization(.never)
            .border(.secondary)
            Button(action: submitValues) {
                Text("Submit")
            }
        }
        .padding()
    }
    
    func submitValues() {
        let card = Card(front: frontValue, back: backValue)
        modelContext.insert(card)

        frontValue = ""
        backValue = ""
    }
}

#Preview {
    CreateCardView()
        .modelContainer(for: [Card.self], inMemory: true)
}
