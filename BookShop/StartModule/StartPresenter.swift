//
//  StartPresenter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation

class StartPresenter {
    private weak var viewController: StartViewInput?
    private let router: StartRouterInput
    private let interactor: StartInteractorInput

    init(viewController: StartViewInput, router: StartRouterInput, interactor: StartInteractorInput) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }

}

extension StartPresenter: StartViewOutput {
    func didSignUpButtonTapped() {
        router.openSignUpScreen()
    }

    func didLoginButtonTapped() {
        router.openLoginScreen()
    }
}

extension StartPresenter: StartInteractorOutput {

}
