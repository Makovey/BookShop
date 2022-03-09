//
//  SignUpRouter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 17.02.2022.
//

import Foundation
import UIKit

protocol SignUpRouterInput {
    func openHomeScreen(name: String)
}

class SignUpRouter: SignUpRouterInput {
    weak var rootViewController: UIViewController?

    func openHomeScreen(name: String) {
        let viewController = HomeAssembly.createHomeScreen(name: name)
        
        viewController.modalPresentationStyle = .fullScreen
        
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
}
