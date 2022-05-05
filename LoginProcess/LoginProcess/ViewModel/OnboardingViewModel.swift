//
//  OnboardingViewModel.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/05.
//

import paper_onboarding

struct OnboardingViewModel {
    private var items = [OnboardingItemInfo]()

    var itemCount: Int {
        self.items.count
    }

    func shouldShowGetStartedButton(forIndex index: Int) -> Bool {
        index == self.items.count - 1
    }

    mutating func append(_ item: OnboardingItemInfo) {
        self.items.append(item)
    }

    func getItem(at index: Int) -> OnboardingItemInfo {
        self.items[index]
    }
}
