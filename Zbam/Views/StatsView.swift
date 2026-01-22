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
            VStack(spacing: 20) {
                let stats = swipeStats
                
                if stats.right == 0 && stats.left == 0 {
                    ContentUnavailableView(
                        "No Swipe Data",
                        systemImage: "chart.pie",
                        description: Text("Start swiping cards to see statistics")
                    )
                } else {
                    Chart {
                        SectorMark(
                            angle: .value("Count", stats.right),
                            innerRadius: .ratio(0.5),
                            angularInset: 2
                        )
                        .foregroundStyle(.green)
                        .cornerRadius(5)
                        .annotation(position: .overlay) {
                            Text("\(stats.right)")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        
                        SectorMark(
                            angle: .value("Count", stats.left),
                            innerRadius: .ratio(0.5),
                            angularInset: 2
                        )
                        .foregroundStyle(.red)
                        .cornerRadius(5)
                        .annotation(position: .overlay) {
                            Text("\(stats.left)")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(height: 300)
                    .padding()
                    
                    // Legend
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Circle()
                                .fill(.green)
                                .frame(width: 20, height: 20)
                            Text("Right Swipes: \(stats.right)")
                                .font(.headline)
                        }
                        
                        HStack {
                            Circle()
                                .fill(.red)
                                .frame(width: 20, height: 20)
                            Text("Left Swipes: \(stats.left)")
                                .font(.headline)
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Statistics")
        }
    }
}
#Preview(traits: .cardSampleData) {
    StatsView()
}

