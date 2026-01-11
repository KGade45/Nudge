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
        hour: Int,
        minute: Int,
        sound: NotificationSound
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = sound.notificationSound

        var components = DateComponents()
        components.hour = hour
        components.minute = minute

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

    func scheduleRepeatNotifications(
        habit: HabitModel,
        title: String,
        body: String,
        hour: Int,
        minute: Int
    ) {
        let weekdays = weekdays(for: habit.repeatRule)

        for weekday in weekdays {
            var components = DateComponents()
            components.weekday = weekday
            components.hour = hour
            components.minute = minute

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: true
            )

            let identifier = "habit-\(habit.id.uuidString)-\(weekday)"

            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = habit.sound.notificationSound

            let request = UNNotificationRequest(
                identifier: identifier,
                content: content,
                trigger: trigger
            )

            UNUserNotificationCenter.current().add(request)
        }
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

    func sendImmediateNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request)
    }

    func scheduleTimeCheckNotification(
        habitId: UUID,
        hour: Int,
        minute: Int
    ) {
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = ""
        content.sound = nil
        content.userInfo = [
            "habitId": habitId.uuidString,
            "type": "timeCheck"
        ]

        var components = DateComponents()
        components.hour = hour
        components.minute = minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "time-check-\(habitId.uuidString)",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    func weekdays(for rule: RepeatRule) -> [Int] {
        switch rule {
        case .everyday:
            return [1,2,3,4,5,6,7] // Sun–Sat
        case .weekdays:
            return [2,3,4,5,6]     // Mon–Fri
        case .weekends:
            return [1,7]           // Sun, Sat
        }
    }
}
