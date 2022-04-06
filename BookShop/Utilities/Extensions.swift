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
    static func createFuturaFont(fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Futura", size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        
        return font
    }
}
