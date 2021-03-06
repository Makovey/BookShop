//
//  SignUpViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 17.02.2022.
//

import UIKit

protocol SignUpViewInput: AnyObject {
    func didTextFieldsEmpty()
    func didPasswordsNotMatch()
    func showErrorBanner(_ error: ServiceError)
}

protocol SignUpViewOutput {
    func didSignUpButtonTapped(email: String, username: String, password: String, confirmPassword: String)
}

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
    var usernameTextField = TextField()

    lazy var usernameStack: UIStackView = {
        usernameStack = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
        usernameStack.axis = .vertical
        usernameStack.distribution = .equalSpacing
        usernameStack.translatesAutoresizingMaskIntoConstraints = false
        
        return usernameStack
    }()

    let emailLabel = Label(withText: "Email".localized(), fontSize: 18)
    var emailTextField = TextField()

    lazy var emailStack: UIStackView = {
        let emailStack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStack.axis = .vertical
        emailStack.distribution = .equalSpacing
        emailStack.translatesAutoresizingMaskIntoConstraints = false
        
        return emailStack
    }()

    let passwordLabel = Label(withText: "Password".localized(), fontSize: 18)
    var passwordTextField = TextField()
    
    lazy var passwordStack: UIStackView = {
        passwordStack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passwordStack.axis = .vertical
        passwordStack.distribution = .equalSpacing
        passwordStack.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordStack
    }()

    let passwordConfirmLabel = Label(withText: "Confirm Password".localized(), fontSize: Constant.middleFontSize)
    var passwordConfirmTextField = TextField()
    
    lazy var passwordConfirmStack: UIStackView = {
        passwordConfirmStack = UIStackView(arrangedSubviews: [passwordConfirmLabel, passwordConfirmTextField])
        passwordConfirmStack.axis = .vertical
        passwordConfirmStack.distribution = .equalSpacing
        passwordConfirmStack.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordConfirmStack
    }()

    let signUpButton = Button(title: "Sign Up".localized(), fontSize: 18)

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
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.topDistance),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func configureSignUpLabels() {
        view.addSubview(labelsStack)

        NSLayoutConstraint.activate([
            labelsStack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: Constant.topDistance),
            labelsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            labelsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            labelsStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }

    private func configureUsernameStack() {
        view.addSubview(usernameStack)
        
        usernameTextField.returnKeyType = .next
        usernameTextField.textContentType = .name

        NSLayoutConstraint.activate([
            usernameStack.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 50),
            usernameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            usernameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            usernameStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }

    private func configureEmailStack() {
        view.addSubview(emailStack)
        
        emailTextField.autocapitalizationType = .none
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        
        NSLayoutConstraint.activate([
            emailStack.topAnchor.constraint(equalTo: usernameStack.bottomAnchor, constant: Constant.topDistance),
            emailStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            emailStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            emailStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }

    private func configurePasswordStack() {
        view.addSubview(passwordStack)
        
        passwordTextField.returnKeyType = .next
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .name

        NSLayoutConstraint.activate([
            passwordStack.topAnchor.constraint(equalTo: emailStack.bottomAnchor, constant: Constant.topDistance),
            passwordStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            passwordStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            passwordStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }

    private func configurePasswordConfirmStack() {
        view.addSubview(passwordConfirmStack)
        
        passwordConfirmTextField.returnKeyType = .go
        passwordConfirmTextField.isSecureTextEntry = true
        passwordConfirmTextField.textContentType = .name

        NSLayoutConstraint.activate([
            passwordConfirmStack.topAnchor.constraint(equalTo: passwordStack.bottomAnchor, constant: Constant.topDistance),
            passwordConfirmStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            passwordConfirmStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            passwordConfirmStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }

    private func configureSignUpButton() {
        view.addSubview(signUpButton)

        signUpButton.backgroundColor = .label
        signUpButton.setTitleColor(.systemBackground, for: .normal)

        signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.topDistance),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            signUpButton.heightAnchor.constraint(equalToConstant: Constant.bottomHeight)
        ])
    }

    @objc private func signUpAction() {
        output?.didSignUpButtonTapped(email: emailTextField.text ?? "",
                                      username: usernameTextField.text ?? "",
                                      password: passwordTextField.text ?? "",
                                      confirmPassword: passwordConfirmTextField.text ?? "")
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
        default: break
            
        }

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case usernameTextField:
            Animator.animateColorForTextField(usernameTextField, color: .systemYellow)
            view.subviews.first(where: { $0.tag == ClientError.usernameEmpty.rawValue })?.removeFromSuperview()
        case emailTextField:
            Animator.animateColorForTextField(emailTextField, color: .systemYellow)
            view.subviews.first(where: { $0.tag == ClientError.emailEmpty.rawValue })?.removeFromSuperview()
        case passwordTextField:
            Animator.animateColorForTextField(passwordTextField, color: .systemYellow)
            view.subviews.first(where: { $0.tag == ClientError.passwordEmpty.rawValue })?.removeFromSuperview()
        case passwordConfirmTextField:
            Animator.animateColorForTextField(passwordConfirmTextField, color: .systemYellow)
            view.subviews.first(where: { $0.tag == ClientError.confirmPasswordEmpty.rawValue })?.removeFromSuperview()
            view.subviews.first(where: { $0.tag == ClientError.passwordsDontMatch.rawValue })?.removeFromSuperview()
        default: break
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Animator.animateColorForTextField(textField as? TextField, color: .lightGray)
    }

}

extension SignUpViewController: SignUpViewInput {
    func didPasswordsNotMatch() {
        ErrorManager.configureAndAttchToTextField(errorLabel: .passwordsDontMatch, attachTo: passwordConfirmTextField, inView: view)
    }
    
    func didTextFieldsEmpty() {
        for textField in [emailTextField, passwordTextField, usernameTextField, passwordConfirmTextField] where textField.text!.isEmpty {
            switch textField {
            case emailTextField:
                ErrorManager.configureAndAttchToTextField(errorLabel: .emailEmpty, attachTo: textField, inView: view)
            case passwordTextField:
                ErrorManager.configureAndAttchToTextField(errorLabel: .passwordEmpty, attachTo: textField, inView: view)
            case usernameTextField:
                ErrorManager.configureAndAttchToTextField(errorLabel: .usernameEmpty, attachTo: textField, inView: view)
            case passwordConfirmTextField:
                ErrorManager.configureAndAttchToTextField(errorLabel: .confirmPasswordEmpty, attachTo: textField, inView: view)
            default: break
                
            }
        }
    }
    
    func showErrorBanner(_ error: ServiceError) {
        ErrorManager.showErrorBanner(text: error.title)
    }
    
}
