//
//  BSTextField.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 15.02.2022.
//

import Foundation
import UIKit

class BSTextField: UITextField {

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

        font = UIFont(name: "Futura", size: 16)
        minimumFontSize = 12

        createBottomLine()
    }

    private func createBottomLine() {
        var bottomBorder = UIView()
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)

        NSLayoutConstraint.activate([
            bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
            bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            bottomBorder.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
