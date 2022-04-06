//
//  LoginRouter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import UIKit

protocol LoginRouterInput {
    func openHomeScreen(name: String)
}

class LoginRouter: LoginRouterInput {
    weak var rootViewController: UIViewController?

    func openHomeScreen(name: String) {
        let tabBarController = TabBarController(username: name)
                
        tabBarController.modalPresentationStyle = .fullScreen
        rootViewController?.present(tabBarController, animated: true, completion: nil)
    }
}
