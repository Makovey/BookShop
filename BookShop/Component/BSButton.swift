//
//  BSButton.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 14.02.2022.
//

import Foundation
import UIKit

class BSButton: UIButton {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configure()
//    }
//
//    convenience init() {
//        self.init(type: .system)
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(title: String) {
        super.init(frame: .zero)
//        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }

    private func configure() {
        layer.cornerRadius = 20

        titleLabel?.font = UIFont(name: "Futura", size: 18)

        translatesAutoresizingMaskIntoConstraints = false
    }

}
