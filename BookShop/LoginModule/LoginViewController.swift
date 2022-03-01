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

    let welcomeLabel = Label(withText: "Welcome".localized(), fontSize: 24)
    var descriptionLabel: Label {
        let descriptionLabel = Label(withText: "Please, login to start your shopping".localized(), fontSize: Constant.descriptionFontSize)
        descriptionLabel.textColor = .systemGray
        
        return descriptionLabel
    }
    
    lazy var labelsStack: UIStackView = {
       labelsStack = UIStackView(arrangedSubviews: [welcomeLabel, descriptionLabel])
       labelsStack.axis = .vertical
       labelsStack.distribution = .equalSpacing
       labelsStack.translatesAutoresizingMaskIntoConstraints = false
        return labelsStack
    }()
    
    let emailLabel = Label(withText: "Email".localized(), fontSize: Constant.titleFontSize)
    var emailTextField: TextField {
        let emailTextField = TextField()
        emailTextField.autocapitalizationType = .none
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        
        return emailTextField
    }
    
    lazy var emailStack: UIStackView = {
        emailStack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStack.axis = .vertical
        emailStack.distribution = .equalSpacing

        emailStack.translatesAutoresizingMaskIntoConstraints = false
        return emailStack
    }()

    let passwordLabel = Label(withText: "Password".localized(), fontSize: Constant.titleFontSize)
    var passwordTextField: TextField {
        let passwordTextField = TextField()
        passwordTextField.returnKeyType = .go
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
        
        return passwordTextField
    }
    
    lazy var passwordStack: UIStackView = {
        passwordStack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passwordStack.axis = .vertical
        passwordStack.distribution = .equalSpacing

        passwordStack.translatesAutoresizingMaskIntoConstraints = false
        return passwordStack
    }()

    let loginButton = Button(title: "Login".localized())

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
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.topDistance),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func configureWelcomeLabels() {
        view.addSubview(labelsStack)

        NSLayoutConstraint.activate([
            labelsStack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: Constant.topDistance),
            labelsStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constant.sideDistance),
            labelsStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constant.sideDistance),
            labelsStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }

    private func configureEmailStack() {
        view.addSubview(emailStack)

        NSLayoutConstraint.activate([
            emailStack.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 50),
            emailStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constant.sideDistance),
            emailStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constant.sideDistance),
            emailStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }

    private func configurePasswordStack() {
        view.addSubview(passwordStack)

        NSLayoutConstraint.activate([
            passwordStack.topAnchor.constraint(equalTo: emailStack.bottomAnchor, constant: Constant.topDistance),
            passwordStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constant.sideDistance),
            passwordStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constant.sideDistance),
            passwordStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])

    }

    private func configureLoginButton() {
        view.addSubview(loginButton)

        loginButton.backgroundColor = .label
        loginButton.setTitleColor(.systemBackground, for: .normal)

        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.topDistance),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            loginButton.heightAnchor.constraint(equalToConstant: Constant.bottomHeight)
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
