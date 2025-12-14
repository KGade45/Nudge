//
//  InputField.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 07/12/25.
//

import UIKit

class InputField: UIView {

    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        return textField
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(placeholder: String) {
        textField.placeholder = placeholder
    }

    private func setupView() {
        addSubview(textField)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    var text: String? { textField.text }
}

extension InputField {
    func focus() {
        textField.becomeFirstResponder()
    }
}
