//
//  LabelInputViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 14/12/25.
//

import UIKit

final class LabelInputViewController: UIViewController {

    private let inputField = InputField()
    private let initialText: String?
    var onDone: ((String) -> Void)?

    init(initialText: String?) {
        self.initialText = initialText
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        activateConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputField.focus()
    }

    private func setupUI() {
        inputField.config(placeholder: "Enter label")
        view.addSubview(inputField)

        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(doneButton)

        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func activateConstraints() {
        inputField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            inputField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            inputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func doneTapped() {
        if let text = inputField.text, !text.isEmpty {
            onDone?(text)
        }
        dismiss(animated: true)
    }
}
