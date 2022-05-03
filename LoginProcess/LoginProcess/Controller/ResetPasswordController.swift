//
//  ResetPasswordController.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/03.
//

import UIKit

class ResetPasswordController: UIViewController {
    private let gradientLayer = CAGradientLayer()

    private let contentView = UIView()

    private let iconImage = UIImageView(image: .appLogo)

    private let emailTextField: TextInput = {
        let textField = TextInput()
        textField.setPlaceholder("Email")
        return textField
    }()

    private lazy var resetPasswordButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Reset Password", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addAction(UIAction(handler: self.handleResetPassword), for: .touchUpInside)
        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBackground
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addAction(UIAction(handler: self.handleDismissal), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer.frame = self.view.bounds
    }

    // MARK: - Actions

    private func handleResetPassword(_: UIAction) {}

    private func handleDismissal(_: UIAction) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - UI Configuration

    private func configureUI() {
        self.configureGradientBackground(layer: self.gradientLayer)
        self.configureScrollView()
        self.configureBackButton()
        self.configureIconImage()
        self.configureTextFields()
    }

    private func configureBackButton() {
        self.contentView.addSubview(self.backButton)
        self.backButton.anchor(
            top: self.view.safeAreaLayoutGuide.topAnchor,
            leading: self.view.safeAreaLayoutGuide.leadingAnchor,
            paddingTop: 16,
            paddingLeft: 16
        )
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
            resetPasswordButton
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
    }
}
