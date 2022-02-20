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

    var labelsStack = UIStackView()
    let signUpLabel = BSLabel(withText: "Sign Up", fontSize: 24)
    let desciptionLabel = BSLabel(withText: "Create your new account", fontSize: 14)

    var usernameStack = UIStackView()
    let usernameLabel = BSLabel(withText: "Username", fontSize: 18)
    let usernameTextField = BSTextField()

    var emailStack = UIStackView()
    let emailLabel = BSLabel(withText: "Email", fontSize: 18)
    let emailTextField = BSTextField()

    var passwordStack = UIStackView()
    let passwordLabel = BSLabel(withText: "Password", fontSize: 18)
    let passwordTextField = BSTextField()

    var passwordConfirmStack = UIStackView()
    let passwordConfirmLabel = BSLabel(withText: "Confirm Password", fontSize: 18)
    let passwordConfirmTextField = BSTextField()

    let signUpButton = BSButton(title: "Sign Up")

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
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func configureSignUpLabels() {
        labelsStack = UIStackView(arrangedSubviews: [signUpLabel, desciptionLabel])
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

    private func configureUsernameStack() {
        usernameStack = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
        usernameStack.axis = .vertical
        usernameStack.distribution = .equalSpacing

        usernameStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(usernameStack)

        NSLayoutConstraint.activate([
            usernameStack.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 50),
            usernameStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            usernameStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            usernameStack.heightAnchor.constraint(equalToConstant: 60)
        ])

        usernameTextField.returnKeyType = .next
        usernameTextField.textContentType = .name
    }

    private func configureEmailStack() {
        emailStack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStack.axis = .vertical
        emailStack.distribution = .equalSpacing

        emailStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(emailStack)

        NSLayoutConstraint.activate([
            emailStack.topAnchor.constraint(equalTo: usernameStack.bottomAnchor, constant: 40),
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

        passwordTextField.returnKeyType = .next
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
    }

    private func configurePasswordConfirmStack() {
        passwordConfirmStack = UIStackView(arrangedSubviews: [passwordConfirmLabel, passwordConfirmTextField])
        passwordConfirmStack.axis = .vertical
        passwordConfirmStack.distribution = .equalSpacing

        passwordConfirmStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(passwordConfirmStack)

        NSLayoutConstraint.activate([
            passwordConfirmStack.topAnchor.constraint(equalTo: passwordStack.bottomAnchor, constant: 40),
            passwordConfirmStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            passwordConfirmStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            passwordConfirmStack.heightAnchor.constraint(equalToConstant: 60)
        ])

        passwordConfirmTextField.returnKeyType = .go
        passwordConfirmTextField.isSecureTextEntry = true
        passwordConfirmTextField.textContentType = .password
    }

    private func configureSignUpButton() {
        view.addSubview(signUpButton)

        signUpButton.backgroundColor = .label
        signUpButton.setTitleColor(.systemBackground, for: .normal)

        signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
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
