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
        let triggerType: TriggerModel.TriggerType =
        TriggerModel.TriggerType(rawValue: self.type ?? "") ?? .time
        
        let hour: Int? = triggerType == .time ? Int(self.hour) : nil
        let minute: Int? = triggerType == .time ? Int(self.minute) : nil
        
        let latitude: Double? =
            triggerType == .location ? self.latitude?.doubleValue : nil

        let longitude: Double? =
            triggerType == .location ? self.longitude?.doubleValue : nil

        let radius: Double? =
            triggerType == .location ? self.radius?.doubleValue : nil

        let locationName: String? = triggerType == .location ? self.locationName : nil
        
        return TriggerModel(
            id: self.id ?? {
                assertionFailure("Trigger id should never be nil")
                return UUID()
            }(),
            type: triggerType,
            hour: hour,
            minute: minute,
            latitude: latitude,
            longitude: longitude,
            radius: radius,
            locationName: locationName
        )
    }

    convenience init(from model: TriggerModel,
                     habit: Habit,
                     context: NSManagedObjectContext) {

        self.init(context: context)

        self.id = model.id
        self.type = model.type.rawValue
        self.habit = habit

        // Time trigger
        self.hour = Int16(model.hour ?? 0)
        self.minute = Int16(model.minute ?? 0)

        // Location trigger
        self.latitude = model.latitude as NSNumber?
        self.longitude = model.longitude as NSNumber?
        self.radius = model.radius as NSNumber?
        self.locationName = model.locationName

        // Inactivity
        self.inactivityHours = 0
    }
}
