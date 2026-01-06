//
//  NotificationManager.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 06/01/26.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}
    
    private let center = UNUserNotificationCenter.current()
    
    func scheduleTimeNotification(
        habitId: UUID,
        title: String,
        body: String,
        hour: Int
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        var components = DateComponents()
        components.hour = hour
        components.minute = 0

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )

        let identifier = "habit-\(habitId.uuidString)"

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    
    func cancelNotification(for habitId: UUID) {
        center.removePendingNotificationRequests(
            withIdentifiers: ["habit-\(habitId.uuidString)"]
        )
    }

    func notificationHour(for habit: HabitModel) -> Int {
        habit.preferredStartHour
    }

    func scheduleAfterMinutes(
        habitId: UUID,
        title: String,
        body: String,
        minutes: Int
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(minutes * 60),
            repeats: false
        )

        let identifier = "habit-\(habitId.uuidString)"

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

}
