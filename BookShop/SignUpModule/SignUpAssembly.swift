//
//  SignUpAssembly.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 17.02.2022.
//

import Foundation
import UIKit

class SignUpAssembly {
    static func createSignUpScreen() -> UIViewController {
        let view = SignUpViewController()
        let router = SignUpRouter()
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter(viewController: view, router: router, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
