//
//  SplashPresenter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation

class SplashPresenter {
    private weak var viewController: SplashViewInput?
    private let router: SplashRouterInput
    private let interactor: SplashInteractorInput
    
    init(viewController: SplashViewInput, router: SplashRouterInput, interactor: SplashInteractorInput) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
    
}


extension SplashPresenter: SplashViewOutput {
    func didSignUpButtonTapped() {
        router.openSignUpScreen()
    }
    
    func didLoginButtonTapped() {
        router.openLoginScreen()
    }
}

extension SplashPresenter: SplashInteractorOutput {
    
}
