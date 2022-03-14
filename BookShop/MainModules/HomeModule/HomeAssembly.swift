//
//  HomeAssembly.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 04.03.2022.
//

import UIKit

class HomeAssembly {
    static func createHomeScreen(name: String) -> UIViewController {
        let view = HomeViewController()
        let router = HomeRouter()
        let interactor = HomeInteractor()
        
        let presenter = HomePresenter(viewController: view, router: router, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        router.rootViewController = view
        
        view.name = name
        
        return view
    }
}
