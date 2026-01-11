//
//  HomeCollectionViewCell.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 09/12/25.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Card title"
        label.font = UIFont(name: "AvenirNext-Medium", size: 24)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let checkmark: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "checkmark.seal.fill")
        imageview.tintColor = .systemGreen
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()

    let capsuleView: InfoCapsule = {
        let view = InfoCapsule()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.config(title: "Evening", color: .systemBlue)
        return view
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 14)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(checkmark)
        containerView.addSubview(capsuleView)
        containerView.addSubview(statusLabel)
        containerView.addSubview(timeLabel)
        setupConstraints()
        setupShadow()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),

            checkmark.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            checkmark.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            checkmark.heightAnchor.constraint(equalToConstant: 20),

            capsuleView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            capsuleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            capsuleView.widthAnchor.constraint(equalToConstant: 80),
            capsuleView.heightAnchor.constraint(equalToConstant: 18),

            statusLabel.topAnchor.constraint(equalTo: capsuleView.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            statusLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),

            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            timeLabel.topAnchor.constraint(equalTo: checkmark.bottomAnchor, constant: 4)

        ])
    }

    func configure(with habit: HabitModel) {
        titleLabel.text = habit.title

        // MARK: - Time
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"

        let today = Date()
        var components = Calendar.current.dateComponents([.hour, .minute], from: today)
        components.hour = habit.preferredStartHour
        components.minute = 0

        if let date = Calendar.current.date(from: components) {
            timeLabel.text = formatter.string(from: date)
        }

        // MARK: - Completion state
        let isCompletedToday: Bool = {
            guard let lastCompleted = habit.lastCompletedAt else { return false }
            return Calendar.current.isDateInToday(lastCompleted)
        }()

        checkmark.isHidden = !isCompletedToday

        // Slight dimming if completed
        containerView.alpha = isCompletedToday ? 0.9 : 1.0

        // MARK: - Capsule (time of day)
        let hour = habit.preferredStartHour
        let capsuleTitle: String
        let capsuleColor: UIColor

        switch hour {
        case 5..<12:
            capsuleTitle = "Morning"
            capsuleColor = .systemBlue
        case 12..<17:
            capsuleTitle = "Afternoon"
            capsuleColor = .systemOrange
        case 17..<22:
            capsuleTitle = "Evening"
            capsuleColor = .systemPurple
        default:
            capsuleTitle = "Night"
            capsuleColor = .systemGray
        }

        capsuleView.config(title: capsuleTitle, color: capsuleColor)

        // MARK: - Status
        statusLabel.text = isCompletedToday
            ? "Completed for today 🎉"
            : "Tap to mark as done"
    }

    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
        layer.masksToBounds = false
    }
}
