//
//  SplashViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation
import UIKit

protocol SplashViewInput: AnyObject {}

protocol SplashViewOutput {
    func didLoginButtonTapped()
    func didSignUpButtonTapped()
}

class SplashViewController: UIViewController {
    var output: SplashViewOutput?

    let logoImage = UIImageView()
    let loginButton = BSButton(title: "Login")
    let signUpButton = BSButton(title: "Sign Up")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        configureLogoImage()
        configureLoginButton()
        configureSignUpButton()
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
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -115),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
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
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func loginButtonTapped() {
        output?.didLoginButtonTapped()
    }

    @objc private func signUpButtonTapped() {
        output?.didSignUpButtonTapped()
    }

}

extension SplashViewController: SplashViewInput {

}
