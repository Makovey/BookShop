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
    func getLoginResponse(loginResponse: ConfirmUserDTO)
    func errorFromService(error: Failure)
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
        networkService.loginWith(loginData: loginData) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.output?.getLoginResponse(loginResponse: data)
                    self?.networkService.saveToken(from: data)
                case .failure(let networkError):
                    switch networkError {
                    case .serverError:
                        self?.output?.errorFromService(error: .serverError)
                    case .unauthorizeError:
                        self?.output?.errorFromService(error: .unauthorized)
                    case .incorrectDataError:
                        self?.output?.errorFromService(error: .incorrectData)
                    case .noInternetConnectionError:
                        self?.output?.errorFromService(error: .noInternetConnection)
                    }
                }
            }
        }
    }
}
