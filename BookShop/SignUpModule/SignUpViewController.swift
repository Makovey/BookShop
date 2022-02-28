//
//  SignUpViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 17.02.2022.
//

import UIKit

protocol SignUpViewInput: AnyObject {}

protocol SignUpViewOutput {}

class SignUpViewController: UIViewController {
    var output: SignUpViewOutput?

    let logoImage = UIImageView()

    let signUpLabel = Label(withText: "Sign Up".localized(), fontSize: 24)
    var descriptionLabel: Label {
        let descriptionLabel = Label(withText: "Create your new account".localized(), fontSize: 14)
        descriptionLabel.textColor = .systemGray
        
        return descriptionLabel
    }
    
    lazy var labelsStack: UIStackView = {
        labelsStack = UIStackView(arrangedSubviews: [signUpLabel, descriptionLabel])
        labelsStack.axis = .vertical
        labelsStack.distribution = .equalSpacing
        labelsStack.translatesAutoresizingMaskIntoConstraints = false

        return labelsStack
    }()

    let usernameLabel = Label(withText: "Username".localized(), fontSize: 18)
    var usernameTextField: TextField {
        let usernameTextField = TextField()
        usernameTextField.returnKeyType = .next
        usernameTextField.textContentType = .name
        
        return usernameTextField
    }
    
    lazy var usernameStack: UIStackView = {
        usernameStack = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
        usernameStack.axis = .vertical
        usernameStack.distribution = .equalSpacing
        usernameStack.translatesAutoresizingMaskIntoConstraints = false
        
        return usernameStack
    }()

    let emailLabel = Label(withText: "Email".localized(), fontSize: 18)
    var emailTextField: TextField {
        let emailTextField = TextField()
        emailTextField.autocapitalizationType = .none
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        
        return emailTextField
    }

    lazy var emailStack: UIStackView = {
        let emailStack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStack.axis = .vertical
        emailStack.distribution = .equalSpacing
        emailStack.translatesAutoresizingMaskIntoConstraints = false
        
        return emailStack
    }()

    let passwordLabel = Label(withText: "Password".localized(), fontSize: 18)
    var passwordTextField: TextField {
        let passwordTextField = TextField()
        passwordTextField.returnKeyType = .next
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

    let passwordConfirmLabel = Label(withText: "Confirm Password".localized(), fontSize: K.titleFontSize)
    var passwordConfirmTextField: TextField {
        let passwordConfirmTextField = TextField()
        passwordConfirmTextField.returnKeyType = .go
        passwordConfirmTextField.isSecureTextEntry = true
        passwordConfirmTextField.textContentType = .password
        
        return passwordConfirmTextField
    }
    
    lazy var passwordConfirmStack: UIStackView = {
        passwordConfirmStack = UIStackView(arrangedSubviews: [passwordConfirmLabel, passwordConfirmTextField])
        passwordConfirmStack.axis = .vertical
        passwordConfirmStack.distribution = .equalSpacing
        passwordConfirmStack.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordConfirmStack
    }()

    let signUpButton = Button(title: "Sign Up".localized())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        createDismissKeyboardTapGesture()

        configureLogoImage()
        configureSignUpLabels()
        configureUsernameStack()
        configureEmailStack()
        configurePasswordStack()
        configurePasswordConfirmStack()
        configureSignUpButton()
    }

    private func configureLogoImage() {
        view.addSubview(logoImage)

        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "logo")

        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: K.topDistance),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func configureSignUpLabels() {
        view.addSubview(labelsStack)

        NSLayoutConstraint.activate([
            labelsStack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: K.topDistance),
            labelsStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: K.sideDistance),
            labelsStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -K.sideDistance),
            labelsStack.heightAnchor.constraint(equalToConstant: K.stackHeight)
        ])
    }

    private func configureUsernameStack() {
        view.addSubview(usernameStack)

        NSLayoutConstraint.activate([
            usernameStack.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 50),
            usernameStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: K.sideDistance),
            usernameStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -K.sideDistance),
            usernameStack.heightAnchor.constraint(equalToConstant: K.stackHeight)
        ])
    }

    private func configureEmailStack() {
        view.addSubview(emailStack)
        
        NSLayoutConstraint.activate([
            emailStack.topAnchor.constraint(equalTo: usernameStack.bottomAnchor, constant: K.topDistance),
            emailStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: K.sideDistance),
            emailStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -K.sideDistance),
            emailStack.heightAnchor.constraint(equalToConstant: K.stackHeight)
        ])
    }

    private func configurePasswordStack() {
        view.addSubview(passwordStack)

        NSLayoutConstraint.activate([
            passwordStack.topAnchor.constraint(equalTo: emailStack.bottomAnchor, constant: K.topDistance),
            passwordStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: K.sideDistance),
            passwordStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -K.sideDistance),
            passwordStack.heightAnchor.constraint(equalToConstant: K.stackHeight)
        ])
    }

    private func configurePasswordConfirmStack() {
        view.addSubview(passwordConfirmStack)

        NSLayoutConstraint.activate([
            passwordConfirmStack.topAnchor.constraint(equalTo: passwordStack.bottomAnchor, constant: K.topDistance),
            passwordConfirmStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: K.sideDistance),
            passwordConfirmStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -K.sideDistance),
            passwordConfirmStack.heightAnchor.constraint(equalToConstant: K.stackHeight)
        ])
    }

    private func configureSignUpButton() {
        view.addSubview(signUpButton)

        signUpButton.backgroundColor = .label
        signUpButton.setTitleColor(.systemBackground, for: .normal)

        signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -K.topDistance),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.sideDistance),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.sideDistance),
            signUpButton.heightAnchor.constraint(equalToConstant: K.bottomHeight)
        ])
    }

    @objc private func signUpAction() {
        print("Sign Up tapped")
    }

    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordConfirmTextField.becomeFirstResponder()
        case passwordConfirmTextField:
            signUpAction()
        default:
            fatalError("Not found textField: - \(textField)")
        }

        return true
    }

}

extension SignUpViewController: SignUpViewInput {

}
