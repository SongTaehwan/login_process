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

    private let iconImage = UIImageView(image: .appLogo)

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

    private lazy var alreadyHaveAccountButton: LabelButton = {
        let button = LabelButton(type: .system)
        button.setAttributedTitle(
            leftText: "Already have an account? ",
            rightText: "Log In",
            rightTextFont: UIFont.boldSystemFont(ofSize: 16)
        )

        button.addAction(UIAction(handler: self.handleLogin), for: .touchUpInside)

        return button
    }()

    var viewModel: RegistrationViewModel?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer.frame = self.view.bounds
    }
}

// MARK: - TextField

extension RegistrationController {
    private func updateForm() {
        self.signUpButton.isEnabled = self.viewModel?.shouldButtonEnable ?? false
        self.signUpButton.backgroundColor = self.viewModel?.buttonBackground
        self.signUpButton.setTitleColor(self.viewModel?.buttonTitleColor, for: .normal)
    }

    private func configureActions() {
        self.emailTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        self.fullnameTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
    }
}

// MARK: - Actions

extension RegistrationController {
    private func handleSignUp(_: UIAction) {
        print("DEBUG: SignUp")
    }

    private func handleLogin(_: UIAction) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func textDidChange(_ sender: TextInput) {
        guard let text = sender.text else { return }

        switch sender {
        case self.emailTextField:
            self.viewModel?.email = text
        case self.passwordTextField:
            self.viewModel?.password = text
        case self.fullnameTextField:
            self.viewModel?.fullname = text
        default:
            return
        }

        self.updateForm()
    }
}

// MARK: - UI Configuration

extension RegistrationController {
    private func configureUI() {
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
        self.alreadyHaveAccountButton.anchor(
            bottom: self.contentView.safeAreaLayoutGuide.bottomAnchor,
            paddingBottom: 5
        )

        self.alreadyHaveAccountButton.topAnchor.constraint(
            greaterThanOrEqualTo: stackView.bottomAnchor,
            constant: 20
        ).isActive = true
    }
}
