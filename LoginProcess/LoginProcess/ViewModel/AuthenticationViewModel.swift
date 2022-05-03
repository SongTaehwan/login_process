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

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?

    var formIsValid: Bool {
        guard let email = self.email, let password = self.password else {
            return false
        }

        return !email.isEmpty && !password.isEmpty
    }

    /// 가독성 위해 만듬
    var shouldButtonEnable: Bool {
        self.formIsValid
    }

    /// 값에 따라 View 의 데이터가 달라지는 경우를 처리하는 것도 ViewModel 의 역할
    var buttonTitleColor: UIColor {
        self.formIsValid ? .white : .buttonTitle
    }

    var buttonBackground: UIColor {
        self.formIsValid ? .enabledBackground : .disabledBackground
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullname: String?

    var formIsValid: Bool {
        guard let email = self.email, let password = self.password, let fullname = self.fullname else {
            return false
        }

        return !email.isEmpty && !password.isEmpty && !fullname.isEmpty
    }

    /// 가독성 위해 만듬
    var shouldButtonEnable: Bool {
        self.formIsValid
    }

    /// 값에 따라 View 의 데이터가 달라지는 경우를 처리하는 것도 ViewModel 의 역할
    var buttonTitleColor: UIColor {
        self.formIsValid ? .white : .buttonTitle
    }

    var buttonBackground: UIColor {
        self.formIsValid ? .enabledBackground : .disabledBackground
    }
}

struct ResetPasswordViewModel: AuthenticationViewModel {
    var email: String?

    var formIsValid: Bool {
        !(self.email?.isEmpty ?? false)
    }

    /// 가독성 위해 만듬
    var shouldButtonEnable: Bool {
        self.formIsValid
    }

    /// 값에 따라 View 의 데이터가 달라지는 경우를 처리하는 것도 ViewModel 의 역할
    var buttonTitleColor: UIColor {
        self.formIsValid ? .white : .buttonTitle
    }

    var buttonBackground: UIColor {
        self.formIsValid ? .enabledBackground : .disabledBackground
    }
}
