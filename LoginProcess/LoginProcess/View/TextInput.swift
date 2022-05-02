//
//  TextInput.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/02.
//

import UIKit

class TextInput: UITextField {
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        self.configureUI()
        self.setPlaceholder()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
        self.setPlaceholder()
    }

    func setPlaceholder(_ placeholder: String = "Text") {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)]
        )
    }

    private func configureUI() {
        let spacer = UIView()
        spacer.setDimensions(width: 12, height: 50)

        self.leftView = spacer
        self.leftViewMode = .always
        self.borderStyle = .none
        self.textColor = .white
        self.keyboardAppearance = .dark
        self.backgroundColor = UIColor(white: 1, alpha: 0.1)
        self.setHeight(50)
        self.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)]
        )
    }
}
