//
//  ProgressViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 09/12/25.
//

import UIKit
import SwiftUI

class ProgressViewController: UIViewController {

    private let progressService = ProgressService()

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
            let result = progressService.weeklyProgress()

            dashboardHostingController?.rootView = ProgressDashboardView(
                title: "Weekly Summary",
                chartData: result.chart,
                completionRate: result.completionRate
            )

        } else {
            let result = progressService.monthlyProgress()

            dashboardHostingController?.rootView = ProgressDashboardView(
                title: "Monthly Summary",
                chartData: result.chart,
                completionRate: result.completionRate
            )
        }
    }
}
