//
//  HomeViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 04.03.2022.
//

import Foundation
import UIKit

protocol HomeViewControllerInput: AnyObject {}

protocol HomeViewControllerOutput {}

class HomeViewController: UIViewController {
    var output: HomeViewControllerOutput?
    
    var nameLabel = Label(withText: "Hello", fontSize: 28)
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension HomeViewController: HomeViewControllerInput {}
