//
//  UIView+Extensions.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/02.
//

import UIKit.UIView

extension UIView {
    // MARK: - AutoLayout

    func setHeight(_ value: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: value).isActive = true
    }

    func setWidth(_ value: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: value).isActive = true
    }

    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }

    func setHeight(toAnchor anchor: NSLayoutAnchor<NSLayoutDimension>, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func setWidth(toAnchor anchor: NSLayoutAnchor<NSLayoutDimension>, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func centerX(inView view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }

    func centerY(inView view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }

    func center(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func centerX(inLayoutGuide layout: UILayoutGuide, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: layout.centerXAnchor, constant: constant).isActive = true
    }

    func centerY(inLayoutGuide layout: UILayoutGuide, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: layout.centerYAnchor, constant: constant).isActive = true
    }

    func center(inLayoutGuide layout: UILayoutGuide) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            centerYAnchor.constraint(equalTo: layout.centerYAnchor)
        ])
    }

    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingRight: CGFloat = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()

        if let top = top {
            let constraint = topAnchor.constraint(equalTo: top, constant: paddingTop)
            constraints.append(constraint)
        }

        if let bottom = bottom {
            let constraint = bottom.constraint(equalTo: bottomAnchor, constant: paddingBottom)
            constraints.append(constraint)
        }

        if let leading = leading {
            let constraint = leadingAnchor.constraint(equalTo: leading, constant: paddingLeft)
            constraints.append(constraint)
        }

        if let trailing = trailing {
            let constraint = trailing.constraint(equalTo: trailingAnchor, constant: paddingRight)
            constraints.append(constraint)
        }

        if let width = width {
            let constraint = widthAnchor.constraint(equalToConstant: width)
            constraints.append(constraint)
        }

        if let height = height {
            let constraint = heightAnchor.constraint(equalToConstant: height)
            constraints.append(constraint)
        }

        NSLayoutConstraint.activate(constraints)
    }

    func fill(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let topAnchor = view.topAnchor
        let leadingAnchor = view.leadingAnchor
        let trailingAnchor = view.trailingAnchor
        let bottomAnchor = view.bottomAnchor

        self.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }

    func fill(inView view: UILayoutGuide) {
        translatesAutoresizingMaskIntoConstraints = false
        let topAnchor = view.topAnchor
        let leadingAnchor = view.leadingAnchor
        let trailingAnchor = view.trailingAnchor
        let bottomAnchor = view.bottomAnchor

        self.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }

    // MARK: - Border

    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()

        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.size.width,
            height: borderWidth
        )

        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()

        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(
            x: 0,
            y: frame.size.height - borderWidth,
            width: frame.size.width, height: borderWidth
        )

        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()

        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        border.frame = CGRect(
            x: 0,
            y: 0,
            width: borderWidth,
            height: frame.size.height
        )

        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()

        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(
            x: frame.size.width - borderWidth,
            y: 0, width: borderWidth,
            height: frame.size.height
        )

        addSubview(border)
    }

    func setCornerRadius(ratio: Double) {
        let width = max(intrinsicContentSize.width, frame.width)
        let height = max(intrinsicContentSize.height, frame.height)

        layer.cornerRadius = min(width, height) * ratio
    }
}
