//
//  CompletionRingView.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 13/12/25.
//

import SwiftUI

struct CompletionRingView: View {
    let progress: Double // 0.0 to 1.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Completion Rate")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .stroke(Color.blue.opacity(0.1), lineWidth: 20)
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            LinearGradient(
                                colors: [Color.blue, Color.cyan],
                                startPoint: .topTrailing,
                                endPoint: .bottomLeading
                            ),
                            style: StrokeStyle(lineWidth: 20, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90)) // Start from top
                        .animation(.easeOut(duration: 1.0), value: progress)

                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.primary)
                }
                .frame(width: 150, height: 150)
                Spacer()
            }
            .padding(.bottom, 10)
        }
        .padding(20)
        .border(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 1), width: 1)
        .cornerRadius(12)
    }
}
