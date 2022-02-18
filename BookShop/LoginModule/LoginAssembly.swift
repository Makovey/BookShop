//
//  LoginAssembly.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import Foundation
import UIKit

class LoginAssembly {
    static func createLoginScreen() -> UIViewController {
        let view = LoginViewController()
        let router = LoginRouter()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(viewController: view, router: router, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
