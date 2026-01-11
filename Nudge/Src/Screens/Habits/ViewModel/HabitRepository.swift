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
            hour: timeTrigger.hour,
            minute: timeTrigger.minute
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
        scheduleNotifications(for: habit)
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
