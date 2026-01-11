//
//  NotificationSound.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 11/01/26.
//

import Foundation
import UserNotifications

enum NotificationSound: String, CaseIterable, Codable {
    case `default` = "Default"
    case chime = "Chime"
    case bell = "Bell"

    var displayName: String {
        rawValue
    }

    var notificationSound: UNNotificationSound {
        switch self {
        case .default:
            return .default
        case .chime:
            return UNNotificationSound(named: UNNotificationSoundName("chime.wav"))
        case .bell:
            return UNNotificationSound(named: UNNotificationSoundName("bell-ring.wav"))
        }
    }
}
