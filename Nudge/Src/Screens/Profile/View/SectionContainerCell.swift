//
//  SectionContainerCell.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 13/12/25.
//

import UIKit

protocol SectionContainerCellDelegate: AnyObject {
    func didTapItem(in section: Int, itemIndex: Int)
}

class SectionContainerCell: UITableViewCell, ProfileItemViewDelegate {

    static let identifier = "SectionContainerCell"

    weak var delegate: SectionContainerCellDelegate?
    private var sectionIndex: Int = 0

    // The White Card Container
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemGroupedBackground // White in light mode
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0 // Spacing handled by internal padding/dividers
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear // Transparent so we see grouped background
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(items: [(name: String, info: String)], section: Int) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        sectionIndex = section
        
        for (index, item) in items.enumerated() {
            let itemView = ProfileItemView()
            // Hide separator for the last item
            let isLast = index == items.count - 1
            itemView.config(name: item.name, value: item.info, showSeparator: !isLast)
            
            itemView.delegate = self
            itemView.tag = index
            stackView.addArrangedSubview(itemView)
        }
    }

    func didTapItem(_ item: ProfileItemView) {
        delegate?.didTapItem(in: sectionIndex, itemIndex: item.tag)
    }
}
