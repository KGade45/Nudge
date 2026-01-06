//
//  Trigger+Ext.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 06/01/26.
//

import Foundation
internal import CoreData

extension Trigger {

    var toTriggerModel: TriggerModel {
        TriggerModel(
            id: self.id ?? {
                assertionFailure("Trigger id should never be nil")
                return UUID()
            }(),
            type: TriggerModel.TriggerType(
                rawValue: self.type ?? ""
            ) ?? .time,
            startHour: 0,   // we’ll refine later
            endHour: 0
        )
    }

    convenience init(from model: TriggerModel,
                     habit: Habit,
                     context: NSManagedObjectContext) {
        self.init(context: context)

        self.id = model.id
        self.type = model.type.rawValue

        // Time-based trigger → no location, no inactivity
        self.inactivityHours = 0
        self.latitude = nil
        self.longitude = nil
        self.radius = nil
        self.locationName = nil

        self.habit = habit
    }
}

