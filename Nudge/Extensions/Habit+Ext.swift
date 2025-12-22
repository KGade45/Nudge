//
//  Habit+Ext.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 21/12/25.
//

internal import CoreData
import Foundation

extension Habit {

    var toHabitModel: HabitModel {
        HabitModel(
            id: self.id ?? {
                assertionFailure("Habit id should never be nil")
                return UUID()
            }(),
            title: self.title ?? "",
            createdAt: self.createdAt ?? Date(),
            isActive: self.isActive,
            preferredStartHour: Int(self.preferredStartHour),
            preferredEndHour: Int(self.preferredEndHour),
            lastCompletedAt: self.lastCompletedAt)
    }
    /// Convenience initializer to map from HabitModel to Core Data Habit
    convenience init(from model: HabitModel, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = model.id
        self.title = model.title
        self.createdAt = model.createdAt
        self.isActive = model.isActive
        self.lastCompletedAt = model.lastCompletedAt
        self.preferredEndHour = Int16(model.preferredEndHour)
        self.preferredStartHour = Int16(model.preferredStartHour)
    }
}
