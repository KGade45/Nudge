//
//  ProgressViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 09/12/25.
//

import UIKit
import SwiftUI

class ProgressViewController: UIViewController {

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Progress"
        label.font = UIFont(name: "Nunito-Bold", size: 34) ?? .systemFont(ofSize: 34, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let segmentedView: UISegmentedControl = {
        let items = ["Week", "Month"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    // We keep a reference to the Dashboard Host
    private var dashboardHostingController: UIHostingController<ProgressDashboardView>?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupUI()
        setupDashboardLayout()

        // Initial Load
        updateDashboard(segmentIndex: 0)

        segmentedView.addTarget(self, action: #selector(segmentedChanged), for: .valueChanged)
    }

    // MARK: - Setup

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(segmentedView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            segmentedView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            segmentedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedView.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func setupDashboardLayout() {
        // Create a dummy initial view
        let initialView = ProgressDashboardView(title: "", chartData: [], completionRate: 0)
        let hostingController = UIHostingController(rootView: initialView)

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Anchor top to the segmented control
            hostingController.view.topAnchor.constraint(equalTo: segmentedView.bottomAnchor, constant: 16),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // Pin to bottom of view (ScrollView handles safe area content insets automatically)
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        self.dashboardHostingController = hostingController
    }

    // MARK: - Logic

    @objc private func segmentedChanged() {
        updateDashboard(segmentIndex: segmentedView.selectedSegmentIndex)
    }

    private func updateDashboard(segmentIndex: Int) {
        if segmentIndex == 0 {
            // WEEKLY DATA
            let data = [
                ChartData(uniqueDay: "Sun", displayLabel: "S", value: 20),
                ChartData(uniqueDay: "Mon", displayLabel: "M", value: 35),
                ChartData(uniqueDay: "Tue", displayLabel: "T", value: 30),
                ChartData(uniqueDay: "Wed", displayLabel: "W", value: 22),
                ChartData(uniqueDay: "Thu", displayLabel: "T", value: 45),
                ChartData(uniqueDay: "Fri", displayLabel: "F", value: 16),
                ChartData(uniqueDay: "Sat", displayLabel: "S", value: 28)
            ]
            
            // Update Dashboard with Weekly Data & 75% Completion
            dashboardHostingController?.rootView = ProgressDashboardView(
                title: "Weekly Summary",
                chartData: data,
                completionRate: 0.75
            )

        } else {
            // MONTHLY DATA
            let rawValues = [40, 55, 70, 30, 90, 60, 45, 88, 73, 54, 66, 41]
            let months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]

            var data: [ChartData] = []
            for (i, val) in rawValues.enumerated() {
                data.append(ChartData(uniqueDay: months[i], displayLabel: months[i], value: Double(val)))
            }

            // Update Dashboard with Monthly Data & 62% Completion
            dashboardHostingController?.rootView = ProgressDashboardView(
                title: "Monthly Summary",
                chartData: data,
                completionRate: 0.62
            )
        }
    }
}
