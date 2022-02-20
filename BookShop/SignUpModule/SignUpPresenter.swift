//
//  SignUpPresenter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 17.02.2022.
//

import Foundation

class SignUpPresenter {
    private weak var viewController: SignUpViewInput?
    private let router: SignUpRouterInput
    private let interactor: SignUpInteractorInput

    init(viewController: SignUpViewInput, router: SignUpRouterInput, interactor: SignUpInteractorInput) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}

extension SignUpPresenter: SignUpViewOutput {

}

extension SignUpPresenter: SignUpInteractorOutput {

}
