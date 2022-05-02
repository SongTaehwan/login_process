//
//  LoginViewController.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/02.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    private func configureUI() {
        navigationController?.navigationBar.barStyle = .black

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradientLayer.locations = [0, 1]
        self.view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.view.bounds
    }


}
