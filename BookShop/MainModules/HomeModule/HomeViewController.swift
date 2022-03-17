//
//  HomeViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 04.03.2022.
//

import Foundation
import UIKit

protocol HomeViewControllerInput: AnyObject {}

protocol HomeViewControllerOutput {
    func viewDidLoad()
}

class HomeViewController: UIViewController {
    var output: HomeViewControllerOutput?
        
    var name: String?
    
    lazy var nameLabel = Label(withText: name ?? "", fontSize: 28)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance)
        ])
    }
}

extension HomeViewController: HomeViewControllerInput {}
