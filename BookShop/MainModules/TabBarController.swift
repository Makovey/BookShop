//
//  TabBarController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 19.03.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    let username: String
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemYellow
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let homeScreen = HomeAssembly.createHomeScreen(name: username)
        let cartScreen = CartAssembly.createCartScreen()
        let profileScreen = ProfileAssembly.createProfileScreen()
        
        guard let houseIcon = UIImage.init(systemName: "house") else { return }
        guard let cartIcon = UIImage.init(systemName: "cart")  else { return }
        guard let personIcon =  UIImage.init(systemName: "person") else { return }
        
        let homeNC = createNavController(for: homeScreen, title: "Home".localized(), image: houseIcon)
        let cartNC = createNavController(for: cartScreen, title: "Cart".localized(), image: cartIcon)
        let profileNC = createNavController(for: profileScreen, title: "Profile".localized(), image: personIcon)

        viewControllers = [homeNC, cartNC, profileNC]
    }
    
    private func createNavController(for viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = image
        navController.title = title
        
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
