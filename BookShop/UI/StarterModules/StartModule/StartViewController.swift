//
//  StartViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation
import UIKit

protocol StartViewInput: AnyObject {}

protocol StartViewOutput {
    func didLoginButtonTapped()
    func didSignUpButtonTapped()
}

class StartViewController: UIViewController {
    var output: StartViewOutput?

    let logoImage = UIImageView()
    let loginButton = Button(title: "Login".localized(), fontSize: Constant.middleFontSize)
    let signUpButton = Button(title: "Sign Up".localized(), fontSize: Constant.middleFontSize)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        configureLogoImage()
        configureSignUpButton()
        configureLoginButton()
    }

    private func configureLogoImage() {
        view.addSubview(logoImage)

        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "logo")

        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func configureLoginButton() {
        view.addSubview(loginButton)

        loginButton.backgroundColor = .label
        loginButton.setTitleColor(.systemBackground, for: .normal)

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: signUpButton.safeAreaLayoutGuide.bottomAnchor, constant: -75),
            loginButton.trailingAnchor.constraint(equalTo: signUpButton.trailingAnchor),
            loginButton.leadingAnchor.constraint(equalTo: signUpButton.leadingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: Constant.bottomHeight)
        ])
    }

    private func configureSignUpButton() {
        view.addSubview(signUpButton)

        signUpButton.layer.borderWidth = 2
        signUpButton.layer.borderColor = UIColor.label.cgColor
        signUpButton.backgroundColor = .systemBackground
        signUpButton.setTitleColor(.label, for: .normal)

        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            signUpButton.heightAnchor.constraint(equalToConstant: Constant.bottomHeight)
        ])
    }

    @objc private func loginButtonTapped() {
        output?.didLoginButtonTapped()
    }

    @objc private func signUpButtonTapped() {
        output?.didSignUpButtonTapped()
    }

}

extension StartViewController: StartViewInput {

}
