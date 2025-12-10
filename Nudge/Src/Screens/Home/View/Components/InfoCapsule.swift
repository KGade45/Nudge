//
//  InfoCapsule.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 10/12/25.
//

import UIKit

class InfoCapsule: UIView {

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(title: String, color: UIColor){
        containerView.backgroundColor = color.withAlphaComponent(0.2)
        titleLabel.text = title
        titleLabel.textColor = color
    }

    func setupView() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
//            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}
