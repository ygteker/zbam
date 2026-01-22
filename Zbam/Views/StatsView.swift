//
//  StatsView.swift
//  Zbam
//
//  Created by Yagiz Gunes Teker on 22.01.26.
//

import SwiftUI
import SwiftData
import Charts

struct StatsView: View {
    @Query private var cards: [Card]
    @State private var selectedSector: String? = nil
    
    private var swipeStats: (right: Int, left: Int) {
        var rightCount = 0
        var leftCount = 0
        
        for card in cards {
            for swipe in card.lastSwipes {
                if swipe == "r" {
                    rightCount += 1
                } else if swipe == "l" {
                    leftCount += 1
                }
            }
        }
        
        return (rightCount, leftCount)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    let stats = swipeStats
                    
                    if stats.right == 0 && stats.left == 0 {
                        ContentUnavailableView(
                            "No Swipe Data",
                            systemImage: "chart.pie",
                            description: Text("Start swiping cards to see statistics")
                        )
                    } else {
                        ZStack {
                            Chart {
                                SectorMark(
                                    angle: .value("Count", stats.right),
                                    innerRadius: .ratio(0.5),
                                    angularInset: 4
                                )
                                .foregroundStyle(.green)
                                .cornerRadius(6)
                                .opacity(selectedSector == "left" ? 0.5 : 1.0)
                                .annotation(position: .overlay) {
                                    Text("\(stats.right)")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
                                
                                
                                SectorMark(
                                    angle: .value("Count", stats.left),
                                    innerRadius: .ratio(0.5),
                                    angularInset: 4
                                )
                                .foregroundStyle(.red)
                                .cornerRadius(6)
                                .opacity(selectedSector == "right" ? 0.5 : 1.0)
                                .annotation(position: .overlay) {
                                    Text("\(stats.left)")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
                            }
                            .frame(height: 300)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
                            }
                            .scaleEffect(selectedSector != nil ? 1.05 : 1.0)
                            
                            // Invisible tap areas
                            HStack(spacing: 0) {
                                Color.clear
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation {
                                            toggleSector("left")
                                        }
                                    }
                                
                                Color.clear
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation {
                                            toggleSector("right")
                                        }
                                    }
                            }
                            .frame(height: 300)
                            .padding()
                        }
                        .padding()
                        
                        // Show list when sector is selected
                        if let sector = selectedSector {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(sector.capitalized) Swipes Details")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                ForEach(cardsForSector(sector), id: \.id) { card in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(card.front)
                                                .font(.headline)
                                            Text(card.back)
                                                .font(.subheadline)
                                                .foregroundStyle(.secondary)
                                        }
                                        Spacer()
                                        Text("\(countSwipes(for: card, sector: sector))")
                                            .font(.title3)
                                            .bold()
                                            .foregroundStyle(sector == "right" ? .green : .red)
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                }
                            }
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Statistics")
        }
    }
    
    private func toggleSector(_ sector: String) {
        if selectedSector == sector {
            selectedSector = nil
        } else {
            selectedSector = sector
        }
    }
    
    private func cardsForSector(_ sector: String) -> [Card] {
        return cards.filter { card in
            let swipeChar = sector == "right" ? "r" : "l"
            return card.lastSwipes.contains(swipeChar)
        }
    }
    
    private func countSwipes(for card: Card, sector: String) -> Int {
        let swipeChar = sector == "right" ? "r" : "l"
        return card.lastSwipes.filter { $0 == swipeChar }.count
    }
}
#Preview {
    @Previewable @State var container: ModelContainer = {
        let container = try! ModelContainer(
            for: Card.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        // Create cards with swipes
        let card1 = Card(front: "Table", back: "der Tisch")
        card1.swipeRight()
        card1.swipeRight()
        card1.swipeLeft()
        card1.swipeRight()
        
        let card2 = Card(front: "Apple", back: "der Apfel")
        card2.swipeRight()
        card2.swipeRight()
        card2.swipeRight()
        
        let card3 = Card(front: "Car", back: "das Auto")
        card3.swipeLeft()
        card3.swipeLeft()
        card3.swipeRight()
        
        let card4 = Card(front: "City", back: "die Stadt")
        card4.swipeLeft()
        card4.swipeLeft()
        card4.swipeLeft()
        card4.swipeLeft()
        
        container.mainContext.insert(card1)
        container.mainContext.insert(card2)
        container.mainContext.insert(card3)
        container.mainContext.insert(card4)
        
        return container
    }()
    
    StatsView()
        .modelContainer(container)
}

