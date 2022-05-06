//
//  LabelButton.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/03.
//

import UIKit

class LabelButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }

    private func configureUI() {
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.5
    }

    func setAttributedTitle(
        leftText: String,
        rightText: String,
        leftTextFont: UIFont? = nil,
        rightTextFont: UIFont? = nil
    ) {
        let attributesForTitle: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: leftTextFont ?? UIFont.systemFont(ofSize: 15)
        ]

        let attributedTitle = NSMutableAttributedString(
            string: leftText,
            attributes: attributesForTitle
        )

        let boldAttribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: rightTextFont ?? UIFont.boldSystemFont(ofSize: 15)
        ]

        attributedTitle.append(NSAttributedString(string: rightText, attributes: boldAttribute))

        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
