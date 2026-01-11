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

        let triggerType = TriggerModel.TriggerType(
            rawValue: self.type ?? ""
        ) ?? .time

        let latitude: Double? =
            triggerType == .location ? self.latitude?.doubleValue : nil

        let longitude: Double? =
            triggerType == .location ? self.longitude?.doubleValue : nil

        let radius: Double? =
            triggerType == .location ? self.radius?.doubleValue : nil

        let locationName: String? =
            triggerType == .location ? self.locationName : nil

        return TriggerModel(
            id: self.id ?? {
                assertionFailure("Trigger id should never be nil")
                return UUID()
            }(),
            type: triggerType,

            // Time
            hour: triggerType == .time ? Int(self.hour) : 0,
            minute: triggerType == .time ? Int(self.minute) : 0,

            // Location
            latitude: latitude,
            longitude: longitude,
            radius: radius,
            locationName: locationName,

            // Inactivity
            inactivityHours: triggerType == .inactivity
                ? Int(self.inactivityHours)
                : 0
        )
    }
}

extension Trigger {

    convenience init(
        from model: TriggerModel,
        habit: Habit,
        context: NSManagedObjectContext
    ) {
        self.init(context: context)

        self.id = model.id
        self.type = model.type.rawValue
        self.habit = habit

        // Reset everything (VERY IMPORTANT)
        self.hour = 0
        self.minute = 0
        self.latitude = nil
        self.longitude = nil
        self.radius = nil
        self.locationName = nil
        self.inactivityHours = 0

        switch model.type {

        case .time:
            self.hour = Int16(model.hour)
            self.minute = Int16(model.minute)

        case .location:
            self.latitude = model.latitude.map { NSNumber(value: $0) }
            self.longitude = model.longitude.map { NSNumber(value: $0) }
            self.radius = NSNumber(value: model.radius ?? 150)
            self.locationName = model.locationName

        case .inactivity:
            self.inactivityHours = Int16(model.inactivityHours)
        }
    }
}
