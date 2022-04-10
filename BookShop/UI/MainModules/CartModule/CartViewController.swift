//
//  CartViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 18.03.2022.
//

import UIKit

class CartViewController: UIViewController {
    
    let cartLabel = Label(withText: "Cart", fontSize: Constant.middleFontSize)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureCartLabel()
    }
    
    private func configureCartLabel() {
        view.addSubview(cartLabel)
        
        cartLabel.translatesAutoresizingMaskIntoConstraints = false
        cartLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            cartLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            cartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            cartLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance)
        ])
    }
}
