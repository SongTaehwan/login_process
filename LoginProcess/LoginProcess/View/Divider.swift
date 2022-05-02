//
//  Divider.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/02.
//

import UIKit

class Divider: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }

    private func configureUI() {
        let label = UILabel()
        label.text = "OR"
        label.textColor = UIColor(white: 1, alpha: 0.87)
        label.font = UIFont.systemFont(ofSize: 14)

        self.addSubview(label)

        label.center(inView: self)

        let dividerLeft = UIView()
        dividerLeft.backgroundColor = UIColor(white: 1, alpha: 0.25)

        self.addSubview(dividerLeft)

        dividerLeft.centerY(inView: self)
        dividerLeft.anchor(
            leading: self.leadingAnchor,
            trailing: label.leadingAnchor,
            paddingLeft: 8,
            paddingRight: 8,
            height: 1
        )

        let dividerRight = UIView()
        dividerRight.backgroundColor = UIColor(white: 1, alpha: 0.25)

        self.addSubview(dividerRight)

        dividerRight.centerY(inView: self)
        dividerRight.anchor(
            leading: label.trailingAnchor,
            trailing: self.trailingAnchor,
            paddingLeft: 8,
            paddingRight: 8,
            height: 1
        )
    }
}
