//
//  BSTextField.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import Foundation
import UIKit

class TextField: UITextField {
    
    let bottomBorder = UIView.init(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        textColor = .label
        tintColor = .label

        font = UIFont.createFuturaFont(fontSize: 16)
        minimumFontSize = 12

        createBottomLine()
    }

    private func createBottomLine() {
        bottomBorder.backgroundColor = .lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)

        NSLayoutConstraint.activate([
            bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            bottomBorder.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBorder.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
