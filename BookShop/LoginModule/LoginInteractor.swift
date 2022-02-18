//
//  LoginInteractor.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import Foundation

protocol LoginInteractorInput {}

protocol LoginInteractorOutput: AnyObject {}

class LoginInteractor {
    weak var output: LoginInteractorOutput?
}

extension LoginInteractor: LoginInteractorInput {}
