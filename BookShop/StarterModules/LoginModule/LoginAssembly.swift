//
//  LoginAssembly.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import UIKit

class LoginAssembly {
    static func createLoginScreen() -> UIViewController {
        let view = LoginViewController()
        let router = LoginRouter()
        
        let networkService = NetworkService()
        let interactor = LoginInteractor(networkService: networkService)
        
        let presenter = LoginPresenter(viewController: view, router: router, interactor: interactor)

        view.output = presenter
        interactor.output = presenter
        
        router.rootViewController = view

        return view
    }
}
