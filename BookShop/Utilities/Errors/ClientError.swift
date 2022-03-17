//
//  ClientError.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 17.03.2022.
//

import Foundation

enum ClientError: Int {
    case emailEmpty = 1
    case passwordEmpty
    case confirmPasswordEmpty
    case usernameEmpty
    case passwordsDontMatch
    
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
        case .passwordsDontMatch:
            return "Your password do not match".localized()
        }
    }
}
