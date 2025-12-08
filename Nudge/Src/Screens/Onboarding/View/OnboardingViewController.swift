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

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Login")
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let emailInput: InputField = {
        let input = InputField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.config(placeholder: "Enter email")
        return input
    }()

    let passwordInput: InputField = {
        let input = InputField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.config(placeholder: "Enter password")
        return input
    }()

    let forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password?"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let button: Button = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.config(title: "Login")
        button.button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    let signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        let fullText = "Don't have an account? Sign Up"
        
        // Create an attributed string
        let attributedText = NSMutableAttributedString(string: fullText)
        
        // Make "Sign Up" part system blue
        if let signUpRange = fullText.range(of: "Sign Up") {
            let nsRange = NSRange(signUpRange, in: fullText)
            attributedText.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: nsRange)
        }
        
        // Set the attributed text to the label
        label.attributedText = attributedText
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()

    var originalStackViewTopConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupKeyboardNotifications()

        // Tap gesture to dismiss keyboard when tapping outside text fields
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false  // Important: This allows other gestures to still work
        view.addGestureRecognizer(tapGesture)

        let tap = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        forgotPasswordLabel.addGestureRecognizer(tap)

        // Gesture recognizer for the "Sign Up" part
        let signUpTap = UITapGestureRecognizer(target: self, action: #selector(signUpTapped))
        signUpLabel.addGestureRecognizer(signUpTap)
    }

    @objc func loginButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.button.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.button.alpha = 1.0
            }
        }
        print("Login pressed")
    }

    // MARK: - Keyboard Notifications
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            let halfKeyboardHeight = keyboardHeight / 2
            
            // Adjust the view or stackview's position by only half the keyboard height
            self.originalStackViewTopConstraint?.constant = -halfKeyboardHeight + 20
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        // Reset the top constraint when the keyboard hides
        self.originalStackViewTopConstraint?.constant = 10

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func dismissKeyboard() {
        // Resign the first responder (dismiss the keyboard)
        view.endEditing(true)
    }

    // MARK: - Forgot Password Action
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

    // MARK: - Sign Up Action
    @objc func signUpTapped() {
        print("Sign Up tapped")
    }

    // MARK: - Setup Views
    func setupViews() {
        view.backgroundColor = .white
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(emailInput)
        mainStackView.addArrangedSubview(passwordInput)
        mainStackView.addArrangedSubview(forgotPasswordLabel)
        mainStackView.addArrangedSubview(button)
        mainStackView.addArrangedSubview(signUpLabel)
        view.addSubview(mainStackView)

        // Set up the top constraint for `mainStackView` and save it to adjust during keyboard events
        originalStackViewTopConstraint = mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        originalStackViewTopConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.widthAnchor.constraint(equalToConstant: 400),
        ])

        NSLayoutConstraint.activate([
            emailInput.heightAnchor.constraint(equalToConstant: 40),
            passwordInput.heightAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
        mainStackView.setCustomSpacing(50, after: button)
        NSLayoutConstraint.activate([
            forgotPasswordLabel.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 10),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
