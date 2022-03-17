//
//  Errors.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 13.03.2022.
//

enum ServiceError {
    case serverError
    case incorrectData
    case unauthorized
    case noInternetConnection
    
    var title: String {
        switch self {
        case .serverError:
            return "Something went wrong".localized()
        case .incorrectData:
            return "Incorrect login or password".localized()
        case .unauthorized:
            return "Please, login again and try again".localized()
        case .noInternetConnection:
            return "No internet connection".localized()
        }
    }
}
