//
//  HomeController.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/03.
//

import GoogleSignIn
import UIKit

class HomeController: UIViewController {
    private let gradientLayer = CAGradientLayer()

    private var shouldShowOnboarding = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
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
        RemoteService.checkAuthenticatedUser { result in
            if case let .failure(error) = result {
                print("DEUBG: Fail to check Auth: \(error.localizedDescription)")
                self.presentLoginController()
                return
            }

            if case .success(false) = result {
                print("DEBUG: No signed in")
                self.presentLoginController()
                return
            }

            if self.shouldShowOnboarding {
                self.presentOnboardingController()
            }
        }
    }

    private func logout(completion: @escaping () -> Void) {
        RemoteService.signOutWithFirebase { result in
            if case let .failure(error) = result {
                print("DEBUG: fail to sign out from firebase: \(error.localizedDescription)")
                return
            }

            completion()
        }
    }

    private func presentOnboardingController() {
        let controller = OnboardingController()
        controller.modalPresentationStyle = .fullScreen
        controller.delegate = self
        self.present(controller, animated: true)
    }
}

// MARK: - Actions

extension HomeController: OnboardingControllerDelegate {
    func onboardingControllerWillDismiss(_: OnboardingController) {
        self.shouldShowOnboarding.toggle()
    }
}

extension HomeController {
    @objc private func handleLogout(_: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let logoutAction = UIAlertAction(title: "Sign Out", style: .destructive) { [weak self] _ in
            self?.logout(completion: {
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
