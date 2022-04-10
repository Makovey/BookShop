//
//  BSButton.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation
import UIKit

class Button: UIButton {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(title: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        titleLabel?.font = UIFont.futuraFont(size: fontSize)

        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
}
