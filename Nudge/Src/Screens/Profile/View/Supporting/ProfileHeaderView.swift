//
//  ProfileHeaderView.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 13/12/25.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemGray4
        iv.image = UIImage(systemName: "person.fill")
        iv.tintColor = .systemGray2
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 50
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Kaustubh"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit Profile"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(editLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            editLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            editLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
