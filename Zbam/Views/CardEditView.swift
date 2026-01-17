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
    
    init(card: Card) {
        self.card = card
        self.back = card.back
        self.front = card.front
    }
    
    var body: some View {
        Form {
            TextField("Front", text: $front)
            TextField("Back", text: $back)
        }
    }
}
