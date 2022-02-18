//
//  SplashInteractor.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation

protocol SplashInteractorInput {}

protocol SplashInteractorOutput {}

class SplashInteractor {
    var output: SplashInteractorOutput?
}

extension SplashInteractor: SplashInteractorInput {
    
}
