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
        let vc = LoginAssembly.createLoginScreen()
        rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    func openSignUpScreen() {
        let vc = SignUpAssembly.createSignUpScreen()
        rootViewController?.present(vc, animated: true, completion: nil)
    }
}
