//
//  HabitRepository.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 21/12/25.
//

internal import CoreData
import Foundation

final class HabitRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceManager.shared.context) {
        self.context = context
    }

    func scheduleNotifications(for habit: HabitModel) {
        guard let timeTrigger = habit.triggers.first(where: {
            $0.type == .time
        }) else {
            return
        }

        NotificationManager.shared.scheduleTimeNotification(
            habitId: habit.id,
            title: "Nudge",
            body: "Time for \(habit.title)",
            hour: timeTrigger.hour ?? 0,
            minute: timeTrigger.minute ?? 0, sound: habit.sound
        )
    }

    func scheduleTimeNotificationWithLocationCheck(habit: HabitModel) {

        guard let locationTrigger = habit.triggers.first(where: { $0.type == .location }) else {
            return
        }

        let isAtLocation = LocationManager.shared
            .isUserInsideLocation(trigger: locationTrigger)

        let body: String

        if isAtLocation {
            body = "You're at the right place to \(habit.title)"
        } else {
            body = "It's time for \(habit.title). Go to \(locationTrigger.locationName ?? "the selected place")"
        }

        NotificationManager.shared.scheduleTimeNotification(
            habitId: habit.id,
            title: "Nudge",
            body: body,
            hour: habit.preferredStartHour,
            minute: habit.triggers.first(where: { $0.type == .time })?.minute ?? 0,
            sound: habit.sound
        )
    }

    func markHabitCompleted(_ habit: HabitModel) {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", habit.id as CVarArg)

        do {
            guard let habitEntity = try context.fetch(request).first else { return }
            let calendar = Calendar.current
            if let lastCompleted = habitEntity.lastCompletedAt,
               calendar.isDateInToday(lastCompleted) {
                return
            }

            habitEntity.lastCompletedAt = Date()

            let completion = Completion(context: context)
            completion.id = UUID()
            completion.completedAt = Date()
            completion.habit = habitEntity

            PersistenceManager.shared.saveContext()
            NotificationManager.shared.cancelNotification(for: habit.id)

        } catch {
            assertionFailure("Failed to mark habit completed: \(error)")
        }
    }


    func add(habit: HabitModel) {
        _ = Habit(from: habit, context: context)
        PersistenceManager.shared.saveContext()

        if let timeTrigger = habit.triggers.first(where: { $0.type == .time }) {

            NotificationManager.shared.scheduleRepeatNotifications(
                habit: habit,
                title: "Nudge",
                body: timeNotificationBody(for: habit),
                hour: timeTrigger.hour ?? habit.preferredStartHour,
                minute: timeTrigger.minute ?? 0
            )
        }

        habit.triggers
            .filter { $0.type == .location }
            .forEach {
                LocationManager.shared.registerGeofence(
                    trigger: $0,
                    habitId: habit.id
                )
            }
    }

    private func timeNotificationBody(for habit: HabitModel) -> String {
        guard let locationTrigger = habit.triggers.first(where: { $0.type == .location }) else {
            return "Time for \(habit.title)"
        }

        let isAtLocation = LocationManager.shared
            .isUserInsideLocation(trigger: locationTrigger)

        if isAtLocation {
            return "You're at the right place to \(habit.title)"
        } else {
            let place = locationTrigger.locationName ?? "the selected place"
            return "It's time for \(habit.title). Go to \(place)."
        }
    }

    func fetchAll() -> [HabitModel] {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: true)
        ]

        do {
            return try context.fetch(request).map(\.toHabitModel)
        } catch {
            assertionFailure("Failed to fetch habits: \(error)")
            return []
        }
    }
}
