//
//  TimePickerViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 14/12/25.
//

import UIKit

final class TimePickerViewController: UIViewController {

    var onDone: ((Date) -> Void)?

    private let picker = UIDatePicker()
    private let initialTime: Date

    // MARK: - Init

    init(selectedTime: Date) {
        self.initialTime = selectedTime
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        activateConstraints()
    }

    // MARK: - Setup

    private func setupUI() {
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.date = initialTime
        picker.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(picker)
        view.addSubview(doneButton)
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            picker.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 12),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - UI Components

    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Actions

    @objc private func doneTapped() {
        onDone?(picker.date)
        dismiss(animated: true)
    }
}
