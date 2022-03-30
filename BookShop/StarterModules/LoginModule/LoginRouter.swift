//
//  LoginRouter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import UIKit

protocol LoginRouterInput {
    func createTabBar(username: String)
}

class LoginRouter: LoginRouterInput {
    weak var rootViewController: UIViewController?

    func createTabBar(username: String) {
        let tabBarController = TabBarController(username: username)
                
        tabBarController.modalPresentationStyle = .fullScreen
        rootViewController?.present(tabBarController, animated: true, completion: nil)
    }
}
