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
        let habits = habitRepo.fetchAll()
        guard let habit = habits.first(where: { $0.id == habitId }) else {
            return
        }

        if let lastCompleted = habit.lastCompletedAt,
           Calendar.current.isDateInToday(lastCompleted) {
            return
        }

        guard let locationTrigger = habit.triggers.first(where: {
            $0.type == .location
        }) else {
            return
        }

        let isAtLocation = LocationManager.shared
            .isUserInsideLocation(trigger: locationTrigger)

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
