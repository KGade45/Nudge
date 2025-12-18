//
//  ProfileItemView.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 13/12/25.
//

import UIKit

protocol ProfileItemViewDelegate: AnyObject {
    func didTapItem(_ item: ProfileItemView)
}

class ProfileItemView: UIView {
    
    weak var delegate: ProfileItemViewDelegate?

    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .tertiaryLabel // Light gray
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        setupLayout()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true // Fixed row height
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(chevronImageView)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            // Title: Left
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Chevron: Far Right
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
            chevronImageView.heightAnchor.constraint(equalToConstant: 16),
            
            // Value: To the left of Chevron
            valueLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Separator: Bottom
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    func config(name: String, value: String, showSeparator: Bool) {
        titleLabel.text = name
        valueLabel.text = value
        separatorView.isHidden = !showSeparator
    }

    @objc private func didTap() {
        // Selection animation
        let originalColor = backgroundColor
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroundColor = .systemGray5
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.backgroundColor = originalColor
            }
        }
        delegate?.didTapItem(self)
    }
}
