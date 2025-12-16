//
//  AddHabitViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 09/12/25.
//

import UIKit

final class AddHabitViewController: UIViewController {

    private var habitLabel: String = ""
    private var selectedTime: Date = Date()
    private var selectedLocation: UserSelectedLocation?

    private var labelRow: UIControl { labelRowPair.0 }
    private var labelValueLabel: UILabel { labelRowPair.1 }

    private var locationRow: UIControl { locationRowPair.0 }
    private var locationValueLabel: UILabel { locationRowPair.1 }

    private var soundRow: UIControl { soundRowPair.0 }
    private var repeatRow: UIControl { repeatRowPair.0 }

    // MARK: - UI

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add a Reminder"
        label.font = UIFont(name: "Nunito-Bold", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.layer.cornerRadius = 16
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.08
        label.layer.shadowRadius = 10
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelReminderCard = UIView()
    private let locationSoundCard = UIView()
    private let repeatCard = UIView()
    private let saveCard = UIView()

    private lazy var labelRowPair = makeRow(
        left: "Label",
        right: habitLabel,
        action: #selector(labelTapped)
    )

    private lazy var locationRowPair = makeRow(
        left: "Location",
        right: "Set location",
        action: #selector(locationTapped)
    )

    private lazy var soundRowPair = makeRow(
        left: "Sound",
        right: "Chirp",
        action: #selector(soundTapped)
    )

    private lazy var repeatRowPair = makeRow(
        left: "Repeat",
        right: "Weekdays",
        action: #selector(repeatTapped)
    )


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupUI()
        activateConstraints()
        updateTimeLabel()
    }

    // MARK: - Setup

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(timeLabel)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(timeTapped))
        timeLabel.addGestureRecognizer(tapGesture)

        configureCards()

        view.addSubview(labelReminderCard)
        view.addSubview(locationSoundCard)
        view.addSubview(repeatCard)
        view.addSubview(saveCard)
    }

    private func configureCards() {

        [labelReminderCard, locationSoundCard, repeatCard, saveCard].forEach {
            $0.backgroundColor = .systemBackground
            $0.layer.cornerRadius = 16
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        labelReminderCard.addSubview(labelRow)

        let divider = makeDivider()
        locationSoundCard.addSubview(locationRow)
        locationSoundCard.addSubview(divider)
        locationSoundCard.addSubview(soundRow)

        repeatCard.addSubview(repeatRow)

        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 14
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)

        saveCard.addSubview(saveButton)

        pinRow(labelRow, to: labelReminderCard)
        pinRow(repeatRow, to: repeatCard)

        NSLayoutConstraint.activate([
            locationRow.topAnchor.constraint(equalTo: locationSoundCard.topAnchor),
            locationRow.leadingAnchor.constraint(equalTo: locationSoundCard.leadingAnchor),
            locationRow.trailingAnchor.constraint(equalTo: locationSoundCard.trailingAnchor),
            locationRow.heightAnchor.constraint(equalToConstant: 56),

            divider.topAnchor.constraint(equalTo: locationRow.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: locationSoundCard.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: locationSoundCard.trailingAnchor, constant: -16),
            divider.heightAnchor.constraint(equalToConstant: 1),

            soundRow.topAnchor.constraint(equalTo: divider.bottomAnchor),
            soundRow.leadingAnchor.constraint(equalTo: locationSoundCard.leadingAnchor),
            soundRow.trailingAnchor.constraint(equalTo: locationSoundCard.trailingAnchor),
            soundRow.heightAnchor.constraint(equalToConstant: 56),
            soundRow.bottomAnchor.constraint(equalTo: locationSoundCard.bottomAnchor),

            saveButton.topAnchor.constraint(equalTo: saveCard.topAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: saveCard.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: saveCard.trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: saveCard.bottomAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timeLabel.heightAnchor.constraint(equalToConstant: 72),

            labelReminderCard.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            labelReminderCard.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            labelReminderCard.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            labelReminderCard.heightAnchor.constraint(equalToConstant: 56),

            locationSoundCard.topAnchor.constraint(equalTo: labelReminderCard.bottomAnchor, constant: 16),
            locationSoundCard.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            locationSoundCard.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),

            repeatCard.topAnchor.constraint(equalTo: locationSoundCard.bottomAnchor, constant: 16),
            repeatCard.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            repeatCard.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            repeatCard.heightAnchor.constraint(equalToConstant: 56),

            saveCard.topAnchor.constraint(equalTo: repeatCard.bottomAnchor, constant: 24),
            saveCard.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            saveCard.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func timeTapped() {
        let pickerVC = TimePickerViewController(selectedTime: selectedTime)

        pickerVC.onDone = { [weak self] time in
            self?.selectedTime = time
            self?.updateTimeLabel()
        }

        if let sheet = pickerVC.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    context.maximumDetentValue * 0.3
                }
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }

        present(pickerVC, animated: true)
    }


    @objc private func labelTapped() {
        let vc = LabelInputViewController(initialText: habitLabel)

        vc.onDone = { [weak self] text in
            self?.habitLabel = text
            self?.labelValueLabel.text = text
        }

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }

        present(vc, animated: true)
    }


    @objc private func locationTapped() {
        let mapVC = MapViewController()

        mapVC.onLocationSelected = { [weak self] location in
            self?.selectedLocation = location
            self?.locationValueLabel.text = "Location selected"
            self?.locationValueLabel.textColor = .label

            print("Received location:", location.latitude, location.longitude)
        }
        mapVC.config(selectedLocation: self.selectedLocation)
        navigationController?.pushViewController(mapVC, animated: true)
    }

    @objc private func soundTapped() {
        print("Sound tapped")
    }

    @objc private func repeatTapped() {
        print("Repeat tapped")
    }

    @objc private func saveTapped() {
        print("Save tapped")
    }

    // MARK: - Helpers

    private func updateTimeLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"

        let timeString = formatter.string(from: selectedTime)
        let parts = timeString.split(separator: " ")

        let attributed = NSMutableAttributedString(
            string: String(parts[0]),
            attributes: [
                .font: UIFont.systemFont(ofSize: 48, weight: .bold)
            ]
        )

        attributed.append(NSAttributedString(
            string: " \(parts[1])",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                .foregroundColor: UIColor.secondaryLabel
            ]
        ))

        timeLabel.attributedText = attributed
    }

    private func makeRow(
        left: String,
        right: String,
        action: Selector
    ) -> (UIControl, UILabel) {

        let control = UIControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: action, for: .touchUpInside)

        let leftLabel = UILabel()
        leftLabel.text = left
        leftLabel.font = .systemFont(ofSize: 17)
        leftLabel.translatesAutoresizingMaskIntoConstraints = false

        let rightLabel = UILabel()
        rightLabel.text = right
        rightLabel.font = .systemFont(ofSize: 17)
        rightLabel.textColor = .secondaryLabel
        rightLabel.translatesAutoresizingMaskIntoConstraints = false

        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = .tertiaryLabel
        chevron.translatesAutoresizingMaskIntoConstraints = false

        control.addSubview(leftLabel)
        control.addSubview(rightLabel)
        control.addSubview(chevron)

        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: control.leadingAnchor, constant: 16),
            leftLabel.centerYAnchor.constraint(equalTo: control.centerYAnchor),

            chevron.trailingAnchor.constraint(equalTo: control.trailingAnchor, constant: -16),
            chevron.centerYAnchor.constraint(equalTo: control.centerYAnchor),

            rightLabel.trailingAnchor.constraint(equalTo: chevron.leadingAnchor, constant: -8),
            rightLabel.centerYAnchor.constraint(equalTo: control.centerYAnchor)
        ])

        return (control, rightLabel)
    }


    private func makeDivider() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func pinRow(_ row: UIView, to container: UIView) {
        container.addSubview(row)
        NSLayoutConstraint.activate([
            row.topAnchor.constraint(equalTo: container.topAnchor),
            row.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            row.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            row.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            row.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
