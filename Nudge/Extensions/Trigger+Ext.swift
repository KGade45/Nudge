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
            hour: 0,
            minute: 0
        )
    }

    convenience init(from model: TriggerModel,
                     habit: Habit,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = model.id
        self.type = model.type.rawValue
        
        // Time-based trigger
        self.hour = Int16(model.hour)
        self.minute = Int16(model.minute)
        
        // Clear unused fields
        self.inactivityHours = 0
        self.latitude = nil
        self.longitude = nil
        self.radius = nil
        self.locationName = nil
        
        self.habit = habit
    }
}

