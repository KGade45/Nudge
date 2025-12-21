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

    func add(habit: HabitModel) {
        _ = Habit(from: habit, context: context)
        PersistenceManager.shared.saveContext()
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
