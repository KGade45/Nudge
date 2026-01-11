//
//  TriggerModel.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 06/01/26.
//

import Foundation

struct TriggerModel: Codable {
    enum TriggerType: String, Codable {
        case time
        case location
        case inactivity
    }

    let id: UUID
    let type: TriggerType

    // Time trigger
    let hour: Int
    let minute: Int

    // Location trigger
    let latitude: Double?
    let longitude: Double?
    let radius: Double?
    let locationName: String?

    // Inactivity trigger
    let inactivityHours: Int
}
