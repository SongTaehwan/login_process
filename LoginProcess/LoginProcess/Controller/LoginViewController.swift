//
//  LoginViewController.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/02.
//

import UIKit

class LoginViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()

    private let contentView = UIView()

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

    private lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "btn_google_light_pressed_ios").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle(" Log in with Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addAction(UIAction(handler: self.handleGoogleLogin), for: .touchUpInside)

        return button
    }()

    private lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)

        let attributesForTitle: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(white: 1, alpha: 0.87),
            .font: UIFont.systemFont(ofSize: 15)
        ]

        let attributedTitle = NSMutableAttributedString(
            string: "Don't have an account? ",
            attributes: attributesForTitle
        )

        let boldAttribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(white: 1, alpha: 0.87),
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]

        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: boldAttribute))

        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addAction(UIAction(handler: self.showForgetPassword), for: .touchUpInside)

        return button
    }()

    private let gradientLayer = CAGradientLayer()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer.frame = self.view.bounds
    }

    private func handleLogin(_: UIAction) {}
    private func handleGoogleLogin(_: UIAction) {
        print("Login with google")
    }

    private func showForgetPassword(_: UIAction) {
        print("Print")
    }

    // MARK: - UI Configuration

    private func configureUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .black

        self.configureBackground()
        self.configureScrollView()
        self.configureIconImage()
        self.configureTextFields()
    }

    private func configureBackground() {
        self.gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        self.gradientLayer.locations = [0, 1]
        self.view.layer.addSublayer(self.gradientLayer)
        self.gradientLayer.frame = view.bounds
    }

    private func configureScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.scrollView.fill(inView: self.view.safeAreaLayoutGuide)
        self.contentView.fill(inView: self.scrollView.contentLayoutGuide)
        self.contentView.setWidth(toAnchor: self.scrollView.frameLayoutGuide.widthAnchor)

        // 최소 크기가 화면 전체
        self.contentView.heightAnchor.constraint(
            greaterThanOrEqualTo: self.scrollView.frameLayoutGuide.heightAnchor
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
            loginButton
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

        let bottomStackView = UIStackView(arrangedSubviews: [
            forgotPasswordButton,
            dividerView,
            googleLoginButton
        ])

        bottomStackView.axis = .vertical
        bottomStackView.spacing = 28

        self.contentView.addSubview(bottomStackView)

        bottomStackView.anchor(
            top: stackView.bottomAnchor,
            leading: self.contentView.leadingAnchor,
            trailing: self.contentView.trailingAnchor,
            paddingTop: 24,
            paddingLeft: 32,
            paddingRight: 32
        )

        self.contentView.addSubview(self.dontHaveAccountButton)

        self.dontHaveAccountButton.centerX(inView: self.contentView)
        self.dontHaveAccountButton.anchor(bottom: self.contentView.safeAreaLayoutGuide.bottomAnchor)
        self.dontHaveAccountButton.topAnchor.constraint(
            greaterThanOrEqualTo: bottomStackView.bottomAnchor,
            constant: 20
        ).isActive = true
    }
}
