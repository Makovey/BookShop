//
//  SignUpInteractor.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 17.02.2022.
//

import Foundation

protocol SignUpInteractorInput {}

protocol SignUpInteractorOutput {}

class SignUpInteractor {
    var output: SignUpInteractorOutput?
}

extension SignUpInteractor: SignUpInteractorInput {

}
