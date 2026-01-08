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

    // Time-based trigger fields
    let startHour: Int
    let endHour: Int
}
