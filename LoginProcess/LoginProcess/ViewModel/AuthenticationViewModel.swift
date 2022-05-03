//
//  AuthenticationViewModel.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/03.
//

import Foundation

struct LoginViewModel {
    var email: String = ""
    var password: String = ""

    var formIsValid: Bool {
        !self.email.isEmpty && !self.password.isEmpty
    }
}

struct RegistrationViewModel {}

struct ForgetPasswordViewMode {}
