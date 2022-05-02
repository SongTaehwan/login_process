//
//  AuthButton.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/02.
//

import UIKit

class AuthButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }

    private func configureUI() {
        self.layer.cornerRadius = 5
        self.layer.cornerCurve = .continuous
        self.setTitle("Log In", for: .normal)

        self.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        self.setTitleColor(.init(white: 1, alpha: 0.67), for: .normal)
        self.setHeight(50)
        self.isEnabled = false
    }
}
