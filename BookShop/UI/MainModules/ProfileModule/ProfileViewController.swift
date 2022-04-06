//
//  ProfileViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 18.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileLabel = Label(withText: "Profile", fontSize: Constant.middleFontSize)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureProfileLabel()
    }
    
    private func configureProfileLabel() {
        view.addSubview(profileLabel)
        
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            profileLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance)
        ])
    }

}
