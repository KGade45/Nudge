//
//  LocationManager.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 10/01/26.
//

import Foundation
internal import CoreLocation

final class LocationManager: NSObject {

    static let shared = LocationManager()

    private let manager = CLLocationManager()

    private override init() {
        super.init()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }


    func isUserInsideLocation(trigger: TriggerModel) -> Bool {
        guard
            let lat = trigger.latitude,
            let lon = trigger.longitude,
            let radius = trigger.radius,
            let current = manager.location
        else { return false }

        let target = CLLocation(latitude: lat, longitude: lon)
        return current.distance(from: target) <= radius
    }

    func registerGeofence(trigger: TriggerModel, habitId: UUID) {
        guard
            let lat = trigger.latitude,
            let lon = trigger.longitude,
            let radius = trigger.radius
        else { return }

        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = CLCircularRegion(
            center: center,
            radius: radius,
            identifier: habitId.uuidString
        )

        region.notifyOnEntry = true
        region.notifyOnExit = false

        manager.startMonitoring(for: region)
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager,
                         didEnterRegion region: CLRegion) {

        guard let habitId = UUID(uuidString: region.identifier) else { return }

        let habitRepo = HabitRepository()
        let habits = habitRepo.fetchAll()

        guard let habit = habits.first(where: { $0.id == habitId }) else { return }

        if let lastCompleted = habit.lastCompletedAt,
           Calendar.current.isDateInToday(lastCompleted) {
            return
        }

        if !isWithinTimeWindow(habit: habit) {
            return
        }

        NotificationManager.shared.sendImmediateNotification(
            title: "Nudge",
            body: "You're at the right place to \(habit.title)"
        )
    }

    private func isWithinTimeWindow(habit: HabitModel) -> Bool {
        let calendar = Calendar.current
        let now = Date()

        let currentHour = calendar.component(.hour, from: now)

        return currentHour >= habit.preferredStartHour &&
               currentHour <= habit.preferredEndHour
    }

}
