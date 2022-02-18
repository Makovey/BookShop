//
//  BSStackView.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 16.02.2022.
//

import Foundation
import UIKit

class BSStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(views: [UIView]) {
        super.init(frame: .zero)
    }
    

    
    func configure() {
        
    }
}
