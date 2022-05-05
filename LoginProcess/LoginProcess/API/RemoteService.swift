//
//  Service.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/05.
//

import Firebase
import FirebaseDatabase
import Foundation
import GoogleSignIn

typealias NetworkResult = Result<Bool, Error>
typealias NetworkCompletion = (NetworkResult) -> Void

// TODO: Define custom error
enum RemoteService {
    static func getAuthenticatedUser() -> User? {
        Auth.auth().currentUser
    }

    static func signInWithFirebase(email: String, password: String, completion: @escaping NetworkCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            }

            completion(.success(true))
        }
    }

    static func registerUserWithFirebase(email: String, password: String, fullname: String, completion: @escaping NetworkCompletion) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let result = result else {
                print("DEBUG: fail to create user: \(String(describing: error?.localizedDescription))")
                return
            }

            let uid = result.user.uid
            let userData = ["email": email, "fullname": fullname]
            Self.updateUser(uid: uid, data: userData, completion: completion)
        }
    }

    static func updateUser(uid: String, data: [String: Any], completion: @escaping NetworkCompletion) {
        Database.database().reference().child("users").child(uid).updateChildValues(data) { error, _ in
            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(true))
        }
    }

    // TODO: UIKit 끊기
    static func signInWithGoogle(user: GIDGoogleUser, completion: @escaping NetworkCompletion) {
        let authentication = user.authentication

        guard let idToken = authentication.idToken else { return }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let user = result?.user else { return }
            let userData = ["email": user.email, "fullname": user.displayName]
            Self.updateUser(uid: user.uid, data: userData, completion: completion)
        }
    }

    static func signOutWithFirebase(completion: @escaping NetworkCompletion) {
        do {
            try Auth.auth().signOut()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }

    static func signOutWithGoogle(completion _: @escaping NetworkCompletion) {}
}
