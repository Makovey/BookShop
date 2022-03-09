//
//  SignUpInteractor.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 17.02.2022.
//

import Foundation

protocol SignUpInteractorInput {
    func signUpWith(signUpData: SignUpDTO)
}

protocol SignUpInteractorOutput {
    func checkSignUpResponse(signUpResponse: ConfirmUserDTO?)
}

class SignUpInteractor {
    var output: SignUpInteractorOutput?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension SignUpInteractor: SignUpInteractorInput {
    func signUpWith(signUpData: SignUpDTO) {
        networkService.registerWith(signUpData: signUpData) { data in
            DispatchQueue.main.async {
                self.output?.checkSignUpResponse(signUpResponse: data)
            }
        }
    }
}
