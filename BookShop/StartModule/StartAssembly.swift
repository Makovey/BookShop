//
//  StartAssembly.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation
import UIKit

class StartAssembly {
    static func createStartScreen() -> UIViewController {
        let viewController = StartViewController()
        let router = StartRouter()
        let interactor = StartInteractor()
        let presenter = StartPresenter(viewController: viewController, router: router, interactor: interactor)

        viewController.output = presenter
        interactor.output = presenter

        router.rootViewController = viewController

        return viewController
    }
}
