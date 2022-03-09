//
//  LoginInteractor.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import Foundation

protocol LoginInteractorInput {
    func loginAccountWith(loginData: LoginDTO)
}

protocol LoginInteractorOutput: AnyObject {
    func checkLoginResponse(loginResponse: ConfirmUserDTO?)
}

class LoginInteractor {
    weak var output: LoginInteractorOutput?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension LoginInteractor: LoginInteractorInput {
    func loginAccountWith(loginData: LoginDTO) {
        networkService.authenticateWith(loginData: loginData) { data in
            DispatchQueue.main.async {
                self.output?.checkLoginResponse(loginResponse: data)
            }
        }
    }
}
