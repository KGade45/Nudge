//
//  HabitTimeCheckService.swift .swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 10/01/26.
//

import Foundation

final class HabitTimeCheckService {

    static let shared = HabitTimeCheckService()

    private let habitRepo = HabitRepository()

    private init() {}

    func handleTimeCheck(habitId: UUID) {
        print("⏰ handleTimeCheck called for:", habitId)

        let habits = habitRepo.fetchAll()
        print("📦 habits count:", habits.count)

        guard let habit = habits.first(where: { $0.id == habitId }) else {
            print("❌ Habit not found")
            return
        }

        print("📌 Habit found:", habit.title)

        if let lastCompleted = habit.lastCompletedAt,
           Calendar.current.isDateInToday(lastCompleted) {
            print("✅ Already completed today")
            return
        }

        guard let locationTrigger = habit.triggers.first(where: {
            $0.type == .location
        }) else {
            print("❌ No location trigger")
            return
        }

        print("📍 Location trigger found:", locationTrigger.locationName ?? "nil")

        let isAtLocation = LocationManager.shared
            .isUserInsideLocation(trigger: locationTrigger)

        print("📍 isAtLocation:", isAtLocation)

        if isAtLocation {
            NotificationManager.shared.sendImmediateNotification(
                title: "Nudge",
                body: "You're at the right place to \(habit.title)"
            )
        } else {
            let place = locationTrigger.locationName ?? "the selected place"

            NotificationManager.shared.sendImmediateNotification(
                title: "Nudge",
                body: "It's time for \(habit.title). Go to \(place)."
            )
        }
    }

}
