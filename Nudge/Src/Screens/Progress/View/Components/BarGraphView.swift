//
//  BarGraphView.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 10/12/25.
//

import UIKit

final class BarGraphView: UIView {

    // MARK: - UI
    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let barStackView = UIStackView()

    // MARK: - Config
    private let barWidth: CGFloat = 16     // ✅ Slim
    private let barCornerRadius: CGFloat = 8
    private let maxBarHeight: CGFloat = 140
    private let barSpacing: CGFloat = 24

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.borderWidth = 1

        // Title
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .label

        // ScrollView
        scrollView.showsHorizontalScrollIndicator = false

        // Stack
        barStackView.axis = .horizontal
        barStackView.alignment = .bottom
        barStackView.spacing = barSpacing

        addSubview(titleLabel)
        addSubview(scrollView)
        scrollView.addSubview(barStackView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        barStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            barStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            barStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            barStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            barStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            barStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    // MARK: - Public Config
    func configure(title: String, values: [CGFloat], labels: [String]) {
        titleLabel.text = title
        barStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        guard let maxValue = values.max(), maxValue > 0 else { return }

        for (index, value) in values.enumerated() {

            let container = UIStackView()
            container.axis = .vertical
            container.alignment = .center
            container.spacing = 8

            let bar = UIView()
            bar.backgroundColor = .systemBlue
            bar.layer.cornerRadius = barCornerRadius
            bar.translatesAutoresizingMaskIntoConstraints = false

            let barHeight = (value / maxValue) * maxBarHeight

            let heightConstraint = bar.heightAnchor.constraint(equalToConstant: 0)

            NSLayoutConstraint.activate([
                bar.widthAnchor.constraint(equalToConstant: barWidth),
                heightConstraint
            ])

            let label = UILabel()
            label.text = labels[index]
            label.font = .systemFont(ofSize: 12, weight: .medium)
            label.textColor = .systemGray

            container.addArrangedSubview(bar)
            container.addArrangedSubview(label)

            barStackView.addArrangedSubview(container)

            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut) {
                    heightConstraint.constant = barHeight
                    self.layoutIfNeeded()
                }
            }
        }

        DispatchQueue.main.async {
            self.scrollView.setContentOffset(.zero, animated: false)
        }
    }
}
