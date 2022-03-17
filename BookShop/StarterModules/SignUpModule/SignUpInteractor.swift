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
    func getSignUpResponse(signUpResponse: ConfirmUserDTO)
    func errorFromService(error: ServiceError)
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
        networkService.signUpWith(signUpData: signUpData) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.output?.getSignUpResponse(signUpResponse: data)
                    self?.networkService.saveToken(from: data)
                case .failure(let networkError):
                    self?.output?.errorFromService(error: networkError.failure)
                }
            }
        }
    }
}
