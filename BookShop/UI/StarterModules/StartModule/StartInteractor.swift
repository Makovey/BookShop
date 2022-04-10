//
//  StartInteractor.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation

protocol StartInteractorInput {}

protocol StartInteractorOutput {}

class StartInteractor {
    var output: StartInteractorOutput?
}

extension StartInteractor: StartInteractorInput {

}
