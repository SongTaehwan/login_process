//
//  OnboardingController.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/05.
//

import paper_onboarding

class OnboardingController: UIViewController {
    private var onboardingView = PaperOnboarding()

    var viewModel = OnboardingViewModel()

    private lazy var getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addAction(UIAction(handler: self.dismissOnboarding), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureOnboardingDataSource()
    }

    // NavigationController 를 사용하지 않을 때만 적용됨
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private func configureOnboardingDataSource() {
        let firstItem = OnboardingItemInfo(informationImage: .graph, title: Onboarding.metrics, description: Onboarding.metricsDescription, pageIcon: UIImage(), color: .systemPurple, titleColor: .white, descriptionColor: .white, titleFont: .boldSystemFont(ofSize: 24), descriptionFont: .systemFont(ofSize: 16))

        let secondItem = OnboardingItemInfo(informationImage: .bell, title: Onboarding.dashboard, description: Onboarding.dashboardDescription, pageIcon: UIImage(), color: .systemBlue, titleColor: .white, descriptionColor: .white, titleFont: .boldSystemFont(ofSize: 24), descriptionFont: .systemFont(ofSize: 16))

        let thirdItem = OnboardingItemInfo(informationImage: .grid, title: Onboarding.notifications, description: Onboarding.notificationDescription, pageIcon: UIImage(), color: .systemPink, titleColor: .white, descriptionColor: .white, titleFont: .boldSystemFont(ofSize: 24), descriptionFont: .systemFont(ofSize: 16))

        self.viewModel.append(firstItem)
        self.viewModel.append(secondItem)
        self.viewModel.append(thirdItem)

        self.onboardingView.delegate = self
        self.onboardingView.dataSource = self
        self.onboardingView.reloadInputViews()
    }

    private func dismissOnboarding(_: UIAction) {}

    private func animateGetStartedButton(show: Bool) {
        let alpha: CGFloat = show ? 1 : 0

        UIView.animate(withDuration: 0.3) {
            self.getStartedButton.alpha = alpha
        }
    }
}

extension OnboardingController: PaperOnboardingDelegate {
    func onboardingWillTransitonToIndex(_ index: Int) {
        let shouldShow = self.viewModel.shouldShowGetStartedButton(forIndex: index)
        self.animateGetStartedButton(show: shouldShow)
    }
}

extension OnboardingController: PaperOnboardingDataSource {
    func onboardingItemsCount() -> Int {
        self.viewModel.itemCount
    }

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        self.viewModel.getItem(at: index)
    }
}

extension OnboardingController {
    private func configureUI() {
        self.configureOnboardingView()
        self.configureGetStartedButton()
    }

    private func configureOnboardingView() {
        self.view.addSubview(self.onboardingView)
        self.onboardingView.fill(inView: self.view)
    }

    private func configureGetStartedButton() {
        self.view.addSubview(self.getStartedButton)
        self.getStartedButton.centerX(inView: self.view)
        self.getStartedButton.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -128).isActive = true
        self.getStartedButton.alpha = 0
    }
}
