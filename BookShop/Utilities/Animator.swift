//
//  Animator.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 18.03.2022.
//

import UIKit

struct Animator {
    static func animateColorForTextField(_ textField: TextField?, color: UIColor) {
        UIView.animate(withDuration: 0.3) {
            textField?.bottomBorder.backgroundColor = color
        }
    }
}
