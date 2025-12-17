//
//  MapViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 16/12/25.
//

import CoreLocation
import MapKit
import UIKit

struct UserSelectedLocation {
    let latitude: Double
    let longitude: Double
}

final class MapViewController: UIViewController, MKMapViewDelegate {

    // MARK: - Public callback

    var onLocationSelected: ((UserSelectedLocation) -> Void)?

    // MARK: - Properties

    private let mapView = MKMapView()
    private let locationService = LocationService()
    let annotation = MKPointAnnotation()

    private var selectedLocation: UserSelectedLocation?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupMap()
        setupLocation()
        setupLongPress()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedLocation {
            let coordinate = CLLocationCoordinate2D(
                latitude: selectedLocation.latitude,
                longitude: selectedLocation.longitude
            )
            let region = MKCoordinateRegion(
                center: coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )
            mapView.setRegion(region, animated: true)
            annotation.coordinate = coordinate
            annotation.title = "Selected Location"
            mapView.addAnnotation(annotation)
        }

    }

    // MARK: - Setup

    func config(selectedLocation: UserSelectedLocation? = nil) {
        self.selectedLocation = selectedLocation
    }

    private func setupMap() {
        mapView.frame = view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.showsUserLocation = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneTapped)
        )

        view.addSubview(mapView)
    }

    private func setupLocation() {
        locationService.onLocationUpdate = { [weak self] location in
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )
            self?.mapView.setRegion(region, animated: true)
        }
        locationService.requestPermission()
    }

    private func setupLongPress() {
        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress)
        )
        longPress.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPress)
    }

    // MARK: - Actions

    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }

        let point = gesture.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)

        selectedLocation = UserSelectedLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )

        mapView.removeAnnotations(mapView.annotations)

        annotation.coordinate = coordinate
        annotation.title = "Selected Location"
        mapView.addAnnotation(annotation)
    }

    @objc private func doneTapped() {
        guard let selectedLocation else { return }
        onLocationSelected?(selectedLocation)
        navigationController?.popViewController(animated: true)
    }
}
