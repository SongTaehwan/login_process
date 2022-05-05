//
//  User.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/05.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let hasSeenOnboarding: Bool
    let uid: String

    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid

        // TODO: 다른 방법 찾아보기
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.hasSeenOnboarding = dictionary["hasSeenOnboarding"] as? Bool ?? false
    }
}
