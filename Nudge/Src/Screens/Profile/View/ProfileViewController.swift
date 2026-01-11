//
//  ProfileViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 09/12/25.
//

internal import CoreLocation
import UIKit

class ProfileViewController: UIViewController {

    private var settings = ProfileSettingsStore.shared.load()

    // MARK: - Data Model

    private var sectionsData: [[(name: String, info: String)]] {
        [
            [
                ("Wake-up Time", timeString(settings.wakeUpTime)),
                ("Work Start Time", timeString(settings.workStartTime)),
                ("Dinner Time", timeString(settings.dinnerTime))
            ],
            [
                ("Home Location", settings.homeLocation?.name ?? "Set"),
                ("Office Location", settings.officeLocation?.name ?? "Set")
            ],
            [
                ("Notifications", "Open Settings"),
                ("Location Access", "Open Settings")
            ]
        ]
    }

    
    private let sectionTitles = ["Routine", "Locations", "Permissions"]
    
    // MARK: - UI Components
    
    private lazy var headerView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped) // Grouped style for correct header spacing
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SectionContainerCell.self, forCellReuseIdentifier: SectionContainerCell.identifier)
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set the custom profile header
        tableView.tableHeaderView = headerView
    }
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    private func timeString(_ date: Date?) -> String {
        guard let date else { return "Set" }
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// MARK: - TableView Delegate & DataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1 // We use one container cell per section to get the card look
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionContainerCell.identifier, for: indexPath) as? SectionContainerCell else {
            return UITableViewCell()
        }
        cell.config(items: sectionsData[indexPath.section], section: indexPath.section)
        cell.delegate = self
        return cell
    }
    
    // MARK: - Section Headers

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.text = sectionTitles[section]
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold) // Match Screenshot Boldness
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // Space between sections
    }

    private func handleRoutineTap(index: Int) {
        let pickerVC = TimePickerViewController(
            selectedTime: currentTimeForIndex(index)
        )

        pickerVC.onDone = { [weak self] time in
            guard let self else { return }

            let id: String
            let title: String
            let body: String

            switch index {
            case 0:
                self.settings.wakeUpTime = time
                id = "profile.wakeup"
                title = "Good Morning ☀️"
                body = "Time to wake up"

            case 1:
                self.settings.workStartTime = time
                id = "profile.work"
                title = "Work Time"
                body = "Time to start work"

            case 2:
                self.settings.dinnerTime = time
                id = "profile.dinner"
                title = "Dinner Time 🍽️"
                body = "Time for dinner"

            default:
                return
            }

            ProfileSettingsStore.shared.save(self.settings)

            // Replace existing alarm
            UNUserNotificationCenter.current()
                .removePendingNotificationRequests(withIdentifiers: [id])

            self.scheduleDailyNotification(
                id: id,
                title: title,
                body: body,
                time: time
            )

            self.tableView.reloadData()
        }

        present(pickerVC, animated: true)
    }


    private func handleLocationTap(index: Int) {
        let mapVC = MapViewController()

        mapVC.onLocationSelected = { [weak self] location in
            guard let self else { return }

            let coord = CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            )

            self.reverseGeocode(coordinate: coord) { place in
                DispatchQueue.main.async {

                    let finalLocation = UserSelectedLocation(
                        latitude: location.latitude,
                        longitude: location.longitude,
                        radius: location.radius,
                        name: place ?? location.name,
                        category: location.category
                    )

                    if index == 0 {
                        self.settings.homeLocation = finalLocation
                        LocationManager.shared.registerProfileGeofence(
                            location: finalLocation,
                            identifier: "profile.home"
                        )
                    } else {
                        self.settings.officeLocation = finalLocation
                        LocationManager.shared.registerProfileGeofence(
                            location: finalLocation,
                            identifier: "profile.office"
                        )
                    }

                    ProfileSettingsStore.shared.save(self.settings)
                    self.tableView.reloadData()
                }
            }
        }

        navigationController?.pushViewController(mapVC, animated: true)
    }

    private func reverseGeocode(
        coordinate: CLLocationCoordinate2D,
        completion: @escaping (String?) -> Void
    ) {
        let geocoder = CLGeocoder()
        let location = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )

        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            let placemark = placemarks?.first
            let address = [
                placemark?.name,
                placemark?.locality,
                placemark?.administrativeArea
            ]
            .compactMap { $0 }
            .joined(separator: ", ")

            completion(address.isEmpty ? nil : address)
        }
    }

    private func openSystemSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

    private func scheduleDailyNotification(
        id: String,
        title: String,
        body: String,
        time: Date
    ) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        var components = DateComponents()
        components.hour = hour
        components.minute = minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    private func currentTimeForIndex(_ index: Int) -> Date {
        switch index {
        case 0: return settings.wakeUpTime ?? Date()
        case 1: return settings.workStartTime ?? Date()
        case 2: return settings.dinnerTime ?? Date()
        default: return Date()
        }
    }
}

// MARK: - Actions Delegate

extension ProfileViewController: SectionContainerCellDelegate {
    func didTapItem(in section: Int, itemIndex: Int) {
        switch section {

        case 0:
            handleRoutineTap(index: itemIndex)

        case 1:
            handleLocationTap(index: itemIndex)

        case 2:
            openSystemSettings()

        default:
            break
        }
    }

}
