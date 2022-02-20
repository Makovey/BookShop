//
//  SplashRouter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation
import UIKit

protocol SplashRouterInput {
    func openLoginScreen()
    func openSignUpScreen()
}

class SplashRouter: SplashRouterInput {
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
