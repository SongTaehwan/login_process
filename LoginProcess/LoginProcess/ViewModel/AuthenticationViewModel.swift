//
//  AuthenticationViewModel.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/03.
//

import UIKit

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var shouldButtonEnable: Bool { get }
    var buttonTitleColor: UIColor { get }
    var buttonBackground: UIColor { get }
}
