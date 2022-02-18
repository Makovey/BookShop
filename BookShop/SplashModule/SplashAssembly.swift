//
//  SplashAssembly.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation
import UIKit

class SplashAssembly {
    static func createSplashScreen() -> UIViewController {
        let viewController = SplashViewController()
        let router = SplashRouter()
        let interactor = SplashInteractor()
        let presenter = SplashPresenter(viewController: viewController, router: router, interactor: interactor)
        
        viewController.output = presenter
        interactor.output = presenter
        
        router.rootViewController = viewController
        
        return viewController
    }
}
