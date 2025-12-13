//
//  ProgressChartView.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 13/12/25.
//

import SwiftUI
import Charts

struct ChartData: Identifiable {
    let id = UUID()
    let uniqueDay: String
    let displayLabel: String
    let value: Double
}

struct ProgressChartView: View {
    let title: String
    let data: [ChartData]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)

            Chart(data) { item in
                BarMark(
                    x: .value("Day", item.uniqueDay),
                    y: .value("Value", item.value)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.blue, Color.cyan],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                // Modern rounded corners
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks { value in
                    // 1. Find the index of the current label
                    if let dayName = value.as(String.self),
                       let index = data.firstIndex(where: { $0.uniqueDay == dayName }) {
                        
                        let item = data[index]
                        
                        // 2. Logic: If data > 10 (Monthly), show only even indices (0, 2, 4...)
                        //    Otherwise (Weekly), show all.
                        let isDense = data.count > 10
                        let showLabel = isDense ? (index % 2 == 0) : true
                        
                        if showLabel {
                            AxisValueLabel {
                                Text(item.displayLabel)
                                    // 3. Smaller font for Monthly view to fit 3 letters
                                    .font(.system(size: isDense ? 10 : 12, weight: .bold))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .frame(height: 250)
        }
        .padding(20)
        .border(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 1), width: 1)
        .cornerRadius(12)
    }
}
