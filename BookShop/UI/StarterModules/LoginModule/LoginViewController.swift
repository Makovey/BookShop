//
//  LoginViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import Foundation
import UIKit

protocol LoginViewInput: AnyObject {
    func didTextFieldsEmpty()
    func showErrorFromService(_ error: ServiceError)
}

protocol LoginViewOutput {
    func loginButtonTapped(email: String, password: String)
}

class LoginViewController: UIViewController {
    var output: LoginViewOutput?
    
    let logoImage = UIImageView()
    
    let welcomeLabel = Label(withText: "Welcome".localized(), fontSize: 24)
    var descriptionLabel: Label {
        let descriptionLabel = Label(withText: "Please, login to start your shopping".localized(), fontSize: Constant.smallestFontSize)
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
    
    let emailLabel = Label(withText: "Email".localized(), fontSize: Constant.middleFontSize)
    let emailTextField = TextField()
    
    lazy var emailStack: UIStackView = {
        emailStack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStack.axis = .vertical
        emailStack.distribution = .equalCentering
        emailStack.spacing = 15
        
        emailStack.translatesAutoresizingMaskIntoConstraints = false
        return emailStack
    }()
    
    let passwordLabel = Label(withText: "Password".localized(), fontSize: Constant.middleFontSize)
    let passwordTextField = TextField()
    
    lazy var passwordStack: UIStackView = {
        passwordStack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passwordStack.axis = .vertical
        passwordStack.distribution = .equalSpacing
        
        passwordStack.translatesAutoresizingMaskIntoConstraints = false
        return passwordStack
    }()
    
    let loginButton = Button(title: "Login".localized(), fontSize: Constant.middleFontSize)
    
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
            labelsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            labelsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            labelsStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }
    
    private func configureEmailStack() {
        view.addSubview(emailStack)
        
        emailTextField.autocapitalizationType = .none
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        
        NSLayoutConstraint.activate([
            emailStack.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 50),
            emailStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            emailStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            emailStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }
    
    private func configurePasswordStack() {
        view.addSubview(passwordStack)
        
        passwordTextField.returnKeyType = .go
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
        
        NSLayoutConstraint.activate([
            passwordStack.topAnchor.constraint(equalTo: emailStack.bottomAnchor, constant: Constant.topDistance),
            passwordStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            passwordStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
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
        output?.loginButtonTapped(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
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
        default: break
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            Animator.animateColorForTextField(emailTextField, color: .systemYellow)
            view.subviews.first(where: { $0.tag == ClientError.emailEmpty.rawValue })?.removeFromSuperview()
        case passwordTextField:
            Animator.animateColorForTextField(passwordTextField, color: .systemYellow)
            view.subviews.first(where: { $0.tag == ClientError.passwordEmpty.rawValue })?.removeFromSuperview()
        default: break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Animator.animateColorForTextField(textField as? TextField, color: .lightGray)
    }
}

extension LoginViewController: LoginViewInput {
    func showErrorFromService(_ error: ServiceError) {
        ErrorManager.showErrorBanner(text: error.title)
    }
    
    func didTextFieldsEmpty() {
        for textField in [emailTextField, passwordTextField] where textField.text!.isEmpty {
            switch textField {
            case emailTextField:
                ErrorManager.configureAndAttchToTextField(errorLabel: .emailEmpty, attachTo: textField, inView: view)
            case passwordTextField:
                ErrorManager.configureAndAttchToTextField(errorLabel: .passwordEmpty, attachTo: textField, inView: view)
            default: break
            }
        }
    }
}
