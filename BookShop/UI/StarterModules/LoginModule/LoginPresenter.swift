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
    func loginButtonTapped(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            viewController?.didTextFieldsEmpty()
        } else {
            let loginData = LoginDTO(email: email, password: password)
            interactor.loginAccountWith(loginData: loginData)
        }
        
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func errorFromService(error: ServiceError) {
        viewController?.showErrorFromService(error)
    }
    
    func getLoginResponse(loginResponse: ConfirmUserDTO) {
        router.openHomeScreen(name: loginResponse.username)
    }
    
}
