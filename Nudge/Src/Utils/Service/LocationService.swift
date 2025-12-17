//
//  LocationService.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 16/12/25.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {

    private let locationManager = CLLocationManager()
    var onLocationUpdate: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestPermission(){
        locationManager.requestWhenInUseAuthorization()
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
