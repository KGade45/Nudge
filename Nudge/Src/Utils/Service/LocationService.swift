//
//  LocationService.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 16/12/25.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {

    public static let shared = LocationService()
    private let locationManager = CLLocationManager()
    var onLocationUpdate: ((CLLocation) -> Void)?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestPermission() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("Location permission denied")
        @unknown default:
            break
        }
    }
    func startUpdatingLocation(){
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation(){
        locationManager.stopUpdatingLocation()
    }
    
}

extension LocationService: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus

        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startUpdatingLocation()
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        onLocationUpdate?(location)
    }
}
