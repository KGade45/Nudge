//
//  OnboardingSignUpViewController.swift
//  Nudge
//
//  Created by Harshal Dhawad on 10/12/25.
//

import UIKit

class OnboardingSignUpViewController: UIViewController {

    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let headingLabel: UILabel = {
        let headingLabel = UILabel()
        headingLabel.contentMode = .scaleAspectFill
        headingLabel.text = "Sign up your account"
        headingLabel.tintColor = .label
        headingLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        return headingLabel
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Signup")
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let fullNameInput: InputField = {
        let input = InputField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.config(placeholder: "Full Name")
        return input
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

    let confirmPasswordInput: InputField = {
        let input = InputField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.config(placeholder: "Re enter password")
        return input
    }()

    let button: Button = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.config(title: "Sign Up")
        button.button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()

    let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        let fullText = "Already have an account? Login"

        // Create an attributed string
        let attributedText = NSMutableAttributedString(string: fullText)

        // Make "Sign Up" part system blue
        if let signUpRange = fullText.range(of: "Login") {
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

        // Gesture recognizer for the "Sign Up" part
        let loginTap = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        loginLabel.addGestureRecognizer(loginTap)
    }

    @objc func signUpButtonTapped() {
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

    // MARK: - Sign Up Action
    @objc func loginTapped() {
        print("Sign Up tapped")
    }

    // MARK: - Setup Views
    func setupViews() {
        view.backgroundColor = .systemBackground

        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(headingLabel)
        mainStackView.addArrangedSubview(fullNameInput)
        mainStackView.addArrangedSubview(emailInput)
        mainStackView.addArrangedSubview(passwordInput)
        mainStackView.addArrangedSubview(confirmPasswordInput)
        mainStackView.addArrangedSubview(button)
        mainStackView.addArrangedSubview(loginLabel)
        view.addSubview(mainStackView)


        originalStackViewTopConstraint = mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10)

        let constraints: [NSLayoutConstraint] = [

            // mainStackView Constraints
            originalStackViewTopConstraint!, // Now we include the saved constraint here
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            imageView.heightAnchor.constraint(equalToConstant: 400),

            imageView.widthAnchor.constraint(equalToConstant: 400),

            headingLabel.heightAnchor.constraint(equalToConstant: 40),
            fullNameInput.heightAnchor.constraint(equalToConstant: 40),
            emailInput.heightAnchor.constraint(equalToConstant: 40),
            passwordInput.heightAnchor.constraint(equalToConstant: 40),
            confirmPasswordInput.heightAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),

            button.topAnchor.constraint(equalTo: confirmPasswordInput.bottomAnchor, constant: 40),

            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ]

        NSLayoutConstraint.activate(constraints)

        mainStackView.setCustomSpacing(50, after: button)
        mainStackView.setCustomSpacing(30, after: button)
    }
}
