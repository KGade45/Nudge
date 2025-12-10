//
//  ProgressViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 09/12/25.
//

import UIKit

class ProgressViewController: UIViewController {

    // MARK: - UI

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Progress"
        label.font = UIFont(name: "Nunito-Bold", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let segmentedView: UISegmentedControl = {
        let segmentedView = UISegmentedControl(items: ["Week", "Month"])
        segmentedView.selectedSegmentIndex = 0
        segmentedView.translatesAutoresizingMaskIntoConstraints = false
        segmentedView.addTarget(self, action: #selector(segmentedChanged), for: .valueChanged)
        return segmentedView
    }()

    private let graphView = BarGraphView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupUI()
        setupGraph()
        loadWeeklyData()
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(segmentedView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: segmentedView.leadingAnchor, constant: -12),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),

            segmentedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedView.heightAnchor.constraint(equalToConstant: 36),
            segmentedView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func setupGraph() {
        view.addSubview(graphView)
        graphView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            graphView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            graphView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            graphView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            graphView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }

    // MARK: - Data Loaders

    private func loadWeeklyData() {
        graphView.configure(
            title: "Weekly Summary",
            values: [20, 14, 30, 22, 24, 16],
            labels: ["S", "M", "T", "W", "T", "F"]
        )
    }

    private func loadMonthlyData() {
        graphView.configure(
            title: "Monthly Summary",
            values: [40, 55, 70, 30, 90, 60, 45, 88, 73, 54, 66, 41],
            labels: ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        )
    }

    // MARK: - Actions

    @objc func segmentedChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loadWeeklyData()
        case 1:
            loadMonthlyData()
        default:
            break
        }
    }
}
