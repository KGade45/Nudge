//
//  Habit.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 21/12/25.
//

import Foundation

struct HabitModel: Codable {
    let id: UUID
    let title: String
    let createdAt: Date
    let isActive: Bool
    let preferredStartHour: Int
    let preferredEndHour: Int
    let lastCompletedAt: Date?
}
