//
//  Errors.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 13.03.2022.
//

import Foundation
import UIKit

// название временное, что-то я так и не придумал ничего годного :(
enum Failure: Int {
    case emailEmpty = 1
    case passwordEmpty
    case confirmPasswordEmpty
    case usernameEmpty
    case passwordsDontMatch
    case serverError
    case incorrectData
    case unauthorized
    case noInternetConnection
    
    var title: String {
        switch self {
        case .emailEmpty:
            return "Please, fill your email".localized()
        case .passwordEmpty:
            return "Please, fill your password".localized()
        case .usernameEmpty:
            return "Please, fill your username".localized()
        case .confirmPasswordEmpty:
            return "Please, confirm your password".localized()
        case .serverError:
            return "Something went wrong".localized()
        case .incorrectData:
            return "Incorrect login or password".localized()
        case .unauthorized:
            return "Please, login again and try again".localized()
        case .noInternetConnection:
            return "No internet connection".localized()
        case .passwordsDontMatch:
            return "Your password do not match".localized()
        }
    }
    
    static func configureAndAttchToTextField(errorLabel: Failure, attachTo textField: TextField, inView view: UIView) {
        let label = Label(withText: errorLabel.title, fontSize: Constant.descriptionFontSize)
        label.tag = errorLabel.rawValue
        
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constant.errorsDistance),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance)
        ])
    }
    
    // честно слизано со SO, если есть идеи как сделать его более чистым и понятным...
    static func showErrorBanner(text: String) {
        let container = UIView()
        container.backgroundColor = UIColor.systemRed

        let label = Label(withText: text, fontSize: Constant.titleFontSize)
        label.textAlignment = .center
        
        container.addSubview(label)
            
        let sidePadding: CGFloat = Constant.sideDistance
        let topPadding: CGFloat = Constant.bannerSize
        let bottomPadding: CGFloat = Constant.bannerSize
        let width = UIScreen.main.bounds.width
        
        UIApplication.shared.windows[0].addSubview(container)
        
        let labelSize = label.systemLayoutSizeFitting(CGSize(width: width - (sidePadding * 2.0),
                                                             height: UIView.layoutFittingCompressedSize.height))
        
        var containerRect = CGRect.zero
        containerRect.size = CGSize(width: width, height: labelSize.height + topPadding + bottomPadding)
        container.frame = containerRect
        
        let labelRect = containerRect.inset(by: UIEdgeInsets(top: topPadding, left: sidePadding, bottom: bottomPadding, right: sidePadding))
        label.frame = labelRect
        
        container.frame.origin.y = -container.frame.size.height
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
                container.frame.origin.y = 0
             }, completion: { _ in
                 UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveLinear, animations: {
                     container.frame.origin.y = -container.frame.size.height
                 })
             })
        }
    }
}
