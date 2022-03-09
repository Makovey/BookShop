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
    func didLoginButtonTapped(email: String?, password: String?) {
        if email!.isEmpty || password!.isEmpty {
            viewController?.didTextFieldsEmpty()
        } else {
            let loginData = LoginDTO(email: email!, password: password!)
            interactor.loginAccountWith(loginData: loginData)
        }
        
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func checkLoginResponse(loginResponse: ConfirmUserDTO?) {
        if let loginResponse = loginResponse {
            router.openHomeScreen(name: loginResponse.username)
        } else {
            // func with error
            print("Login response = nil")
        }
    }
    
}
