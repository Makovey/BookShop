//
//  StartRouter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation
import UIKit

protocol StartRouterInput {
    func openLoginScreen()
    func openSignUpScreen()
}

class StartRouter: StartRouterInput {
    weak var rootViewController: UIViewController?

    func openLoginScreen() {
        let viewController = LoginAssembly.createLoginScreen()
        rootViewController?.present(viewController, animated: true, completion: nil)
    }

    func openSignUpScreen() {
        let viewController = SignUpAssembly.createSignUpScreen()
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
}
