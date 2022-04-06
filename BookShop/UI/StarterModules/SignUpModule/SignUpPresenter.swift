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
    
    func didSignUpButtonTapped(email: String, username: String, password: String, confirmPassword: String) {
        if email.isEmpty || username.isEmpty  || password.isEmpty || confirmPassword.isEmpty {
            viewController?.didTextFieldsEmpty()
        } else if password != confirmPassword {
            viewController?.didPasswordsNotMatch()
        } else {
            let signUpData = SignUpDTO(email: email, username: username, password: password)
            interactor.signUpWith(signUpData: signUpData)
        }
    }
    
}

extension SignUpPresenter: SignUpInteractorOutput {
    func errorFromService(error: ServiceError) {
        viewController?.showErrorBanner(error)
    }
    
    func getSignUpResponse(signUpResponse: ConfirmUserDTO) {
        router.openHomeScreen(name: signUpResponse.username)
    }
    
}
