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

    let capsuleView: InfoCapsule = {
        let view = InfoCapsule()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.config(title: "Evening", color: .systemBlue)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(capsuleView)
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

            capsuleView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            capsuleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            capsuleView.widthAnchor.constraint(equalToConstant: 80),
            capsuleView.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
        layer.masksToBounds = false
    }
}
