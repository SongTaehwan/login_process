//
//  LoginViewController.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/02.
//

import UIKit

class LoginViewController: UIViewController {

    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "firebase-logo"))

    private let emailTextField: UITextField = {

        let textField = UITextField()
        let spacer = UIView()

        spacer.setDimensions(width: 12, height: 50)
        textField.leftView = spacer
        textField.leftViewMode = .always

        textField.borderStyle = .none
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(50)
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])

        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        let spacer = UIView()

        spacer.setDimensions(width: 12, height: 50)
        textField.leftView = spacer
        textField.leftViewMode = .always

        textField.borderStyle = .none
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(50)
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])

        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black

        self.configureBackground()
        self.configureIconImage()
        self.configureTextFields()
    }

    private func configureBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradientLayer.locations = [0, 1]
        self.view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.view.frame
    }

    private func configureIconImage() {
        self.view.addSubview(self.iconImage)
        self.iconImage.centerX(inView: self.view)
        self.iconImage.setDimensions(width: 120, height: 120)
        self.iconImage.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    }

    private func configureTextFields() {
        let stackView = UIStackView(arrangedSubviews: [self.emailTextField, self.passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 20

        self.view.addSubview(stackView)

        stackView.anchor(top: self.iconImage.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }


}
