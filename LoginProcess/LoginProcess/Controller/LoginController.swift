//
//  LoginController.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/02.
//

import UIKit

class LoginController: UIViewController {
    private let gradientLayer = CAGradientLayer()

    private let contentView = UIView()

    private let iconImage = UIImageView(image: .appLogo)

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

    private lazy var forgotPasswordButton: LabelButton = {
        let button = LabelButton(type: .system)
        button.setAttributedTitle(
            leftText: "Forgot your password? ",
            rightText: "Get help sigining in"
        )

        button.addAction(UIAction(handler: self.showForgetPassword), for: .touchUpInside)

        return button
    }()

    private let dividerView = Divider()

    private lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.google.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle(" Log in with Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addAction(UIAction(handler: self.handleGoogleLogin), for: .touchUpInside)

        return button
    }()

    private lazy var dontHaveAccountButton: LabelButton = {
        let button = LabelButton(type: .system)
        button.setAttributedTitle(
            leftText: "Don't have an account? ",
            rightText: "Sign Up",
            rightTextFont: UIFont.boldSystemFont(ofSize: 16)
        )

        button.addAction(UIAction(handler: self.showRegistrationController), for: .touchUpInside)

        return button
    }()

    var viewModel: LoginViewModel?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer.frame = self.view.bounds
    }

    private func handleLogin(_: UIAction) {
        print("DEBUG: Login")
    }

    private func handleGoogleLogin(_: UIAction) {
        print("DEBUG: Login with google")
    }

    private func showForgetPassword(_: UIAction) {
        let controller = ResetPasswordController()
        controller.viewModel = ResetPasswordViewModel()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    private func showRegistrationController(_: UIAction) {
        let controller = RegistrationController()
        controller.viewModel = RegistrationViewModel()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - UI Configuration

    private func configureUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .black

        self.configureGradientBackground(layer: self.gradientLayer)
        self.configureScrollView()
        self.configureIconImage()
        self.configureTextFields()
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
        self.dontHaveAccountButton.anchor(
            bottom: self.contentView.safeAreaLayoutGuide.bottomAnchor,
            paddingBottom: 5
        )

        self.dontHaveAccountButton.topAnchor.constraint(
            greaterThanOrEqualTo: bottomStackView.bottomAnchor,
            constant: 20
        ).isActive = true
    }
}
