//
//  UIViewController+Extensions.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/03.
//

import UIKit.UIViewController

extension UIViewController {
    func configureGradientBackground(layer: CAGradientLayer?) {
        let gradientLayer = layer ?? CAGradientLayer()

        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradientLayer.locations = [0, 1]
        self.view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
}
