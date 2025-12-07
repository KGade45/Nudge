//
//  OnboardingViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 07/12/25.
//

import UIKit

class OnboardingViewController: UIViewController {

    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let input: InputField = {
        let input = InputField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.config(placeholder: "Enter email")
        return input
    }()

    let forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password?"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .right
        label.isUserInteractionEnabled = true   // Important!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let button: Button = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.config(title: "Login")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        forgotPasswordLabel.addGestureRecognizer(tap)
    }

    @objc func forgotPasswordTapped() {
        // Visual feedback on tapping "Forgot password"
        UIView.animate(withDuration: 0.1, animations: {
            self.forgotPasswordLabel.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.forgotPasswordLabel.alpha = 1.0
            }
        }
        print("Forgot password")
    }

    func setupViews() {
        view.backgroundColor = .white
        mainStackView.addArrangedSubview(input)
        mainStackView.addArrangedSubview(forgotPasswordLabel)
        mainStackView.addArrangedSubview(button)
        view.addSubview(mainStackView)

//    TODO: - Refactor constraints.

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        NSLayoutConstraint.activate([
            input.heightAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            forgotPasswordLabel.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 10),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
