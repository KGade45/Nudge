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
            statusLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
            
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
