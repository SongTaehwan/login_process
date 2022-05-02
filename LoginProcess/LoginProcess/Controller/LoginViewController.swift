//
//  LoginViewController.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/02.
//

import UIKit

class LoginViewController: UIViewController {
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "firebase-logo"))

    private let emailTextField: TextInput = {
        let textField = TextInput()
        textField.setPlaceholder("Email")
        return textField
    }()

    private let passwordTextField: TextInput = {
        let textField = TextInput()
        textField.isSecureTextEntry = true
        textField.setPlaceholder("Password")
        return textField
    }()

    private lazy var loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.isEnabled = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addAction(UIAction(handler: self.handleLogin), for: .touchUpInside)
        return button
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)

        let attributesForTitle: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(white: 1, alpha: 0.87),
            .font: UIFont.systemFont(ofSize: 15)
        ]

        let attributedTitle = NSMutableAttributedString(
            string: "Forgot your password? ",
            attributes: attributesForTitle
        )

        let boldAttribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(white: 1, alpha: 0.87),
            .font: UIFont.boldSystemFont(ofSize: 15)
        ]

        attributedTitle.append(NSAttributedString(string: "Get help signing in.", attributes: boldAttribute))

        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addAction(UIAction(handler: self.showForgetPassword), for: .touchUpInside)

        return button
    }()

    private let dividerView = Divider()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    private func handleLogin(_: UIAction) {}

    private func showForgetPassword(_: UIAction) {
        print("Print")
    }

    // MARK: - UI Configuration

    private func configureUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .black

        self.configureBackground()
        self.configureIconImage()
        self.configureTextFields()
    }

    private func configureBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradientLayer.locations = [0, 1]
        self.view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.frame
    }

    private func configureIconImage() {
        self.view.addSubview(self.iconImage)
        self.iconImage.centerX(inView: view)
        self.iconImage.setDimensions(width: 120, height: 120)
        self.iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    }

    private func configureTextFields() {
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordTextField,
            loginButton,
            forgotPasswordButton,
            dividerView
        ])

        stackView.axis = .vertical
        stackView.spacing = 20

        self.view.addSubview(stackView)

        stackView.anchor(
            top: self.iconImage.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            paddingTop: 32,
            paddingLeft: 32,
            paddingRight: 32
        )
    }
}
