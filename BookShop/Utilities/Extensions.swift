//
//  Extensions.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 25.02.2022.
//

import Foundation
import UIKit

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

extension String {
    func strikeThrough() -> NSAttributedString {
        return NSAttributedString(
            string: self,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
    }
}

extension UIFont {
    static func futuraFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Futura", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension Button {
    func changeButtonStateToInCart() {
        backgroundColor = .systemGreen
        setTitle("In cart".localized(), for: .normal)
    }
    
    func changeButtonStateToNotInCart() {
        backgroundColor = .label
        setTitle("To cart".localized(), for: .normal)
    }
}
