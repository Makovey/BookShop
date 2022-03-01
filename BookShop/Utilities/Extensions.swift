//
//  Extensions.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 25.02.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
}
