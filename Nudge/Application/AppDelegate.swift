//
//  AppDelegate.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 04/12/25.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        _ = CoreDataManager.shared.context
        NotificationService.shared.requestNotificationPermission()
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {

        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        // No-op
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {

        let userInfo = notification.request.content.userInfo

        guard
            let type = userInfo["type"] as? String,
            type == "timeCheck",
            let habitIdString = userInfo["habitId"] as? String,
            let habitId = UUID(uuidString: habitIdString)
        else {
            return [.banner, .sound]
        }

        HabitTimeCheckService.shared.handleTimeCheck(habitId: habitId)

        return []
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {

        let userInfo = response.notification.request.content.userInfo

        guard
            let type = userInfo["type"] as? String,
            type == "timeCheck",
            let habitIdString = userInfo["habitId"] as? String,
            let habitId = UUID(uuidString: habitIdString)
        else {
            return
        }

        HabitTimeCheckService.shared.handleTimeCheck(habitId: habitId)
    }
}
