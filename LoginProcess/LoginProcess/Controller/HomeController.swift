//
//  HomeController.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/03.
//

import FirebaseAuth
import UIKit

class HomeController: UIViewController {
    private let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        // load 와 함께 인증 검사
        self.authenticateUser()
    }

    private func presentLoginController() {
        let controller = LoginController()
        // Navigation 으로 감싸야 뒤로가기 막을 수 있음
        let navigation = UINavigationController(rootViewController: controller)
        controller.viewModel = LoginViewModel()
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: true)
    }

    // MARK: - API Caller

    private func authenticateUser() {
        guard let user = Auth.auth().currentUser else {
            self.presentLoginController()
            return
        }

        print("DEBUG: Already Signed in user: \(user.email)")
    }

    private func logout(completion: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
            completion()
        } catch {
            print("DEBUG: fail to logout \(error.localizedDescription)")
        }
    }
}

// MARK: - Actions

extension HomeController {
    @objc private func handleLogout(_: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let logoutAction = UIAlertAction(title: "Sign Out", style: .destructive) { [weak self] _ in
            self?.logout(completion: {
                // TODO: Error handling
                self?.presentLoginController()
            })
        }

        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true)
    }
}

// MARK: - UI Configuration

extension HomeController {
    private func configureUI() {
        self.configureGradientBackground(layer: self.gradientLayer)
        self.configureNavigationBar()
    }

    private func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationItem.title = "Welcome Onboard!"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.arrowLeft, style: .plain, target: self, action: #selector(self.handleLogout))
    }
}
