//
//  RegistrationController.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/03.
//

import UIKit

class RegistrationController: UIViewController {
    private let gradientLayer = CAGradientLayer()

    private let contentView = UIView()

    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "firebase-logo"))

    private let emailTextField: TextInput = {
        let textField = TextInput()
        textField.setPlaceholder("Email")
        return textField
    }()

    private let fullnameTextField: TextInput = {
        let textField = TextInput()
        textField.setPlaceholder("Fullname")
        return textField
    }()

    private let passwordTextField: TextInput = {
        let textField = TextInput()
        textField.isSecureTextEntry = true
        textField.setPlaceholder("Password")
        return textField
    }()

    private lazy var signUpButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.isEnabled = false
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addAction(UIAction(handler: self.handleSignUp), for: .touchUpInside)
        return button
    }()

    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)

        let attributesForTitle: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(white: 1, alpha: 0.87),
            .font: UIFont.systemFont(ofSize: 15)
        ]

        let attributedTitle = NSMutableAttributedString(
            string: "Already have an account? ",
            attributes: attributesForTitle
        )

        let boldAttribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(white: 1, alpha: 0.87),
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]

        attributedTitle.append(NSAttributedString(string: "Log In", attributes: boldAttribute))

        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addAction(UIAction(handler: self.handleLogin), for: .touchUpInside)

        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBackground()
        self.configureScrollView()
        self.configureIconImage()
        self.configureTextFields()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer.frame = self.view.bounds
    }

    // MARK: - Action Method

    private func handleSignUp(_: UIAction) {
        print("DEBUG: SignUp")
    }

    private func handleLogin(_: UIAction) {
        print("DEBUG: SignIn")
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - UI Configuration

    private func configureBackground() {
        self.gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        self.gradientLayer.locations = [0, 1]
        self.view.layer.addSublayer(self.gradientLayer)
        self.gradientLayer.frame = view.bounds
    }

    private func configureScrollView() {
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.addSubview(self.contentView)
        scrollView.fill(inView: self.view.safeAreaLayoutGuide)
        self.contentView.fill(inView: scrollView.contentLayoutGuide)
        self.contentView.setWidth(toAnchor: scrollView.frameLayoutGuide.widthAnchor)

        // 최소 크기가 화면 전체
        self.contentView.heightAnchor.constraint(
            greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor
        ).isActive = true
    }

    private func configureIconImage() {
        self.contentView.addSubview(self.iconImage)
        self.iconImage.centerX(inView: self.contentView)
        self.iconImage.setDimensions(width: 120, height: 120)
        self.iconImage.anchor(top: self.contentView.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    }

    private func configureTextFields() {
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordTextField,
            fullnameTextField,
            signUpButton
        ])

        stackView.axis = .vertical
        stackView.spacing = 20

        self.contentView.addSubview(stackView)

        stackView.anchor(
            top: self.iconImage.bottomAnchor,
            leading: self.contentView.leadingAnchor,
            trailing: self.contentView.trailingAnchor,
            paddingTop: 32,
            paddingLeft: 32,
            paddingRight: 32
        )

        self.contentView.addSubview(self.alreadyHaveAccountButton)

        self.alreadyHaveAccountButton.centerX(inView: self.contentView)
        self.alreadyHaveAccountButton.anchor(bottom: self.contentView.safeAreaLayoutGuide.bottomAnchor)
        self.alreadyHaveAccountButton.topAnchor.constraint(
            greaterThanOrEqualTo: stackView.bottomAnchor,
            constant: 20
        ).isActive = true
    }
}
