//
//  ProgressionDashboardView.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 13/12/25.
//

import SwiftUI

struct ProgressDashboardView: View {
    let title: String
    let chartData: [ChartData]
    let completionRate: Double
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ProgressChartView(title: title, data: chartData)
                CompletionRingView(progress: completionRate)
            }
            .padding(.top, 10)
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .background(Color(uiColor: .systemBackground))
    }
}
