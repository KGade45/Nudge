//
//  ProgressService.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 11/01/26.
//

import Foundation

final class ProgressService {
    let progressRepository = ProgressRepository()
    func weeklyProgress() -> (chart: [ChartData], completionRate: Double) {
        let calendar = Calendar.current
        let today = Date()

        guard let weekStart = calendar.date(
            from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        ) else {
            return ([], 0)
        }

        guard let weekEnd = calendar.date(byAdding: .day, value: 7, to: weekStart) else {
            return ([], 0)
        }

        let completions = progressRepository.fetchCompletions(from: weekStart, to: weekEnd)

        var dayCounts: [Int: Int] = [:]

        completions.forEach {
            let weekday = calendar.component(.weekday, from: $0.completedAt!)
            dayCounts[weekday, default: 0] += 1
        }

        let symbols = calendar.shortWeekdaySymbols // Sun..Sat

        var chartData: [ChartData] = []
        for i in 1...7 {
            let value = Double(dayCounts[i] ?? 0)
            chartData.append(
                ChartData(
                    uniqueDay: symbols[i - 1],
                    displayLabel: String(symbols[i - 1].prefix(1)),
                    value: value
                )
            )
        }

        let completedDays = Set(completions.map {
            calendar.startOfDay(for: $0.completedAt!)
        }).count

        let completionRate = Double(completedDays) / 7.0

        return (chartData, completionRate)
    }

    func monthlyProgress() -> (chart: [ChartData], completionRate: Double) {
        let calendar = Calendar.current
        let today = Date()

        guard let monthStart = calendar.date(
            from: calendar.dateComponents([.year, .month], from: today)
        ) else {
            return ([], 0)
        }

        guard let range = calendar.range(of: .day, in: .month, for: today),
              let monthEnd = calendar.date(byAdding: .day, value: range.count, to: monthStart) else {
            return ([], 0)
        }

        let completions = progressRepository.fetchCompletions(from: monthStart, to: monthEnd)

        var dayCounts: [Int: Int] = [:]

        completions.forEach {
            let day = calendar.component(.day, from: $0.completedAt!)
            dayCounts[day, default: 0] += 1
        }

        var chartData: [ChartData] = []
        for day in range {
            chartData.append(
                ChartData(
                    uniqueDay: "\(day)",
                    displayLabel: "\(day)",
                    value: Double(dayCounts[day] ?? 0)
                )
            )
        }

        let completedDays = Set(completions.map {
            calendar.startOfDay(for: $0.completedAt!)
        }).count

        let completionRate = Double(completedDays) / Double(range.count)

        return (chartData, completionRate)
    }
}
