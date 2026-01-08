//
//  NotificationService.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 06/01/26.
//

import Foundation
import UserNotifications

final class NotificationService {
    static let shared = NotificationService()
    func requestNotificationPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) { granted, _ in
                if !granted {
                    print("Notifications not allowed")
                }
            }
    }
}
