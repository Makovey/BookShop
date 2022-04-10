//
//  BSLabel.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import Foundation
import UIKit

class Label: UILabel {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(withText: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        text = withText
        textColor = .label
        font = UIFont.futuraFont(size: fontSize)
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        textColor = .label
        font = UIFont(name: "Futura", size: fontSize)
    }
}
