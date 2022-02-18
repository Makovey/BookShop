//
//  LoginViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import Foundation
import UIKit

protocol LoginViewInput: AnyObject {}

protocol LoginViewOutput {}

class LoginViewController: UIViewController {
    var output: LoginViewOutput?
    
    let logoImage = UIImageView()
    
    var labelsStack = UIStackView()
    let welcomeLabel = BSLabel(withText: "Welcome", fontSize: 24)
    let desciptionLabel = BSLabel(withText: "Please, login or sign up to start your shopping", fontSize: 14)
    
    var emailStack = UIStackView()
    let emailLabel = BSLabel(withText: "Email", fontSize: 18)
    let emailTextField = BSTextField()
    
    var passwordStack = UIStackView()
    let passwordLabel = BSLabel(withText: "Password", fontSize: 18)
    let passwordTextField = BSTextField()
    
    let loginButton = BSButton(title: "Login")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        createDismissKeyboardTapGesture()
        
        configureLogoImage()
        configureWelcomeLabels()
        configureEmailStack()
        configurePasswordStack()
        configureLoginButton()
    }
    
    private func configureLogoImage() {
        view.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "logo")
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureWelcomeLabels() {
        labelsStack = UIStackView(arrangedSubviews: [welcomeLabel, desciptionLabel])
        labelsStack.axis = .vertical
        labelsStack.distribution = .equalSpacing
        
        view.addSubview(labelsStack)
        
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelsStack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            labelsStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            labelsStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            labelsStack.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        desciptionLabel.textColor = .systemGray
    }
    
    private func configureEmailStack() {
        emailStack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStack.axis = .vertical
        emailStack.distribution = .equalSpacing
        
        emailStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emailStack)
        
        NSLayoutConstraint.activate([
            emailStack.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 50),
            emailStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            emailStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            emailStack.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        emailTextField.autocapitalizationType = .none
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
    }
    
    private func configurePasswordStack() {
        passwordStack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passwordStack.axis = .vertical
        passwordStack.distribution = .equalSpacing
        
        passwordStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(passwordStack)
        
        NSLayoutConstraint.activate([
            passwordStack.topAnchor.constraint(equalTo: emailStack.bottomAnchor, constant: 40),
            passwordStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            passwordStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            passwordStack.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        passwordTextField.returnKeyType = .go
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.backgroundColor = .label
        loginButton.setTitleColor(.systemBackground, for: .normal)
        
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func loginAction() {
        print("Login tapped")
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            loginAction()
        default:
            fatalError("Not found textField: - \(textField)")
        }
        return true
    }
}

extension LoginViewController: LoginViewInput {
    
}
