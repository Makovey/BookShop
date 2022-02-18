//
//  LoginPresenter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import Foundation

class LoginPresenter {
    private weak var viewController: LoginViewInput?
    private let router: LoginRouterInput
    private let interactor: LoginInteractorInput
    
    init(viewController: LoginViewInput, router: LoginRouterInput, interactor: LoginInteractorInput) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}


extension LoginPresenter: LoginViewOutput {
    
}

extension LoginPresenter: LoginInteractorOutput {
    
}
