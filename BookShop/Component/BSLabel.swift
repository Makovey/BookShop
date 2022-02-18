//
//  BSLabel.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import Foundation
import UIKit

class BSLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withText: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        text = withText
        textColor = .label
        font = UIFont(name: "Futura", size: fontSize)
    }
    
    func configure() {
        
    }
}
